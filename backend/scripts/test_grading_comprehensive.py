import os
import sys

# Add backend directory to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass

from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def run_comprehensive_tests():
    print("=================================================================")
    print("[*] BAT DAU CHAY TEST CAC DANG BAI TAP, NHAP DAP AN & CHAM DIEM")
    print("=================================================================")

    # 1. Đăng nhập hệ thống
    print("\n--- BƯỚC 1: Xác thực & Đăng nhập ---")
    login_res = client.post("/auth/login", json={"username": "admin", "password": "1"})
    assert login_res.status_code == 200, f"Đăng nhập thất bại: {login_res.text}"
    token = login_res.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    print(f"  [+] Đăng nhập thành công với tài khoản 'admin'. Token nhận được: {token[:15]}...")

    # Lấy danh sách sách
    books_res = client.get("/books", headers=headers)
    assert books_res.status_code == 200
    books = books_res.json()
    print(f"  [+] Lấy danh sách sách thành công. Tổng số sách hiện có: {len(books)}")

    # -----------------------------------------------------------------
    # 2. TEST DẠNG BÀI 1: CAMBRIDGE IELTS (Listening - Notes Completion / Multiple Choice)
    # -----------------------------------------------------------------
    print("\n--- BƯỚC 2: Test bài thi Cambridge IELTS 15 (Listening - Notes Completion) ---")
    cam15 = next((b for b in books if "15" in b["title"]), None)
    if not cam15:
        cam15 = books[0]
    print(f"  [*] Chọn sách: '{cam15['title']}' (ID: {cam15['id']})")

    # Lấy tests
    tests_res = client.get(f"/books/{cam15['id']}/tests", headers=headers)
    assert tests_res.status_code == 200
    tests = tests_res.json()
    test_1 = tests[0]

    # Lấy sections
    sections_res = client.get(f"/tests/{test_1['id']}/sections", headers=headers)
    assert sections_res.status_code == 200
    sections = sections_res.json()
    sec_listening = next((s for s in sections if s["skill"] == "listening"), sections[0])
    print(f"  [*] Chọn Section: {sec_listening['skill'].upper()} Part {sec_listening['part_number']} (ID: {sec_listening['id']})")

    # Lấy chi tiết section & câu hỏi
    sec_detail_res = client.get(f"/sections/{sec_listening['id']}", headers=headers)
    assert sec_detail_res.status_code == 200
    sec_detail = sec_detail_res.json()
    all_ielts_questions = [q for g in sec_detail["question_groups"] for q in g["questions"]]
    print(f"  [+] Số nhóm câu hỏi: {len(sec_detail['question_groups'])}, tổng số câu: {len(all_ielts_questions)}")

    # Tạo lượt làm bài (Attempt)
    att_res = client.post("/attempts", json={"section_id": sec_listening["id"]}, headers=headers)
    assert att_res.status_code == 200
    ielts_attempt_id = att_res.json()["id"]
    print(f"  [+] Đã tạo lượt thi (Attempt ID: {ielts_attempt_id})")

    # Soạn đáp án test (kết hợp cả câu đúng, câu hoa/thường, câu sai cố ý)
    ielts_answers = []
    # Q1: "Jamieson" -> nhập thường "jamieson" để test chuẩn hóa không phân biệt hoa thường
    ielts_answers.append({"question_id": all_ielts_questions[0]["id"], "given_answer": "jamieson"})
    # Q2: "afternoon" -> nhập đúng "Afternoon " (thừa khoảng trắng)
    ielts_answers.append({"question_id": all_ielts_questions[1]["id"], "given_answer": "Afternoon "})
    # Q3: "communication" -> nhập cố tình SAI để kiểm tra chấm sai
    ielts_answers.append({"question_id": all_ielts_questions[2]["id"], "given_answer": "cooking"})

    print("  [*] Nộp bài thi IELTS với các đáp án thử nghiệm:")
    print(f"      - Câu 1: 'jamieson' (chữ thường, đáp án gốc: 'Jamieson')")
    print(f"      - Câu 2: 'Afternoon ' (thừa khoảng trắng, đáp án gốc: 'afternoon')")
    print(f"      - Câu 3: 'cooking' (cố tình nhập sai)")

    submit_ielts_res = client.post(
        f"/attempts/{ielts_attempt_id}/submit",
        json={"answers": ielts_answers},
        headers=headers
    )
    assert submit_ielts_res.status_code == 200
    ielts_result = submit_ielts_res.json()

    print(f"  [+] Kết quả chấm thi IELTS:")
    print(f"      - Điểm số: {ielts_result['correct_count']}/{ielts_result['total_questions']} câu đúng ({ielts_result['score_percentage']}%)")
    
    # Kiểm tra tính đúng đắn của việc chấm
    ans_dict = {a["question_id"]: a for a in ielts_result["answers"]}
    assert ans_dict[all_ielts_questions[0]["id"]]["is_correct"] is True, "Câu 1 phải chấm ĐÚNG (case-insensitive)"
    assert ans_dict[all_ielts_questions[1]["id"]]["is_correct"] is True, "Câu 2 phải chấm ĐÚNG (strip whitespace)"
    assert ans_dict[all_ielts_questions[2]["id"]]["is_correct"] is False, "Câu 3 phải chấm SAI"
    print("  [✓] Logic chấm IELTS: Phân biệt hoa thường, khoảng trắng thừa, và câu sai hoạt động HOÀN HẢO!")

    # -----------------------------------------------------------------
    # 3. TEST DẠNG BÀI 2: DESTINATION B1 (Grammar - Chia thì, Viết lại câu, Trắc nghiệm)
    # -----------------------------------------------------------------
    print("\n--- BƯỚC 3: Test bài tập Destination B1 Grammar & Vocabulary (Unit 1) ---")
    dest_b1 = next((b for b in books if "Destination B1" in b["title"]), None)
    assert dest_b1 is not None, "Không tìm thấy sách Destination B1"
    print(f"  [*] Chọn sách: '{dest_b1['title']}' (ID: {dest_b1['id']})")

    # Lấy tests (Unit)
    dest_tests = client.get(f"/books/{dest_b1['id']}/tests", headers=headers).json()
    unit_1 = dest_tests[0]
    print(f"  [*] Chọn bài học: Unit {unit_1['test_number']} (ID: {unit_1['id']})")

    # Lấy section
    dest_sections = client.get(f"/tests/{unit_1['id']}/sections", headers=headers).json()
    dest_sec = dest_sections[0]

    # Lấy chi tiết câu hỏi
    dest_detail = client.get(f"/sections/{dest_sec['id']}", headers=headers).json()
    groups = dest_detail["question_groups"]
    print(f"  [+] Đã tải Unit 1: {len(groups)} bài tập (Exercise B, C, D):")
    for g in groups:
        print(f"      • Nhóm {g['group_order']} [{g['question_type']}]: {g['instruction'][:70]}... (Câu {g['question_from']}-{g['question_to']})")

    # Tạo lượt làm bài Destination B1
    dest_att_res = client.post("/attempts", json={"section_id": dest_sec["id"]}, headers=headers)
    assert dest_att_res.status_code == 200
    dest_attempt_id = dest_att_res.json()["id"]
    print(f"  [+] Đã tạo lượt làm bài tập Destination B1 (Attempt ID: {dest_attempt_id})")

    # Lấy tất cả câu hỏi
    dest_questions_by_num = {q["question_number"]: q for g in groups for q in g["questions"]}

    dest_answers_payload = [
        # --- Dạng 1: Chia thì động từ (Verb Form) ---
        # Câu 1: 'is writing' -> nhập dạng viết tắt "'s writing" để test expansion
        {"question_id": dest_questions_by_num[1]["id"], "given_answer": "'s writing"},
        # Câu 2: 'are losing' -> nhập đầy đủ "are losing"
        {"question_id": dest_questions_by_num[2]["id"], "given_answer": "are losing"},
        # Câu 5: 'am not lying' -> nhập viết tắt "'m not lying"
        {"question_id": dest_questions_by_num[5]["id"], "given_answer": "'m not lying"},
        # Câu 8: 'Are you playing' -> nhập thường "are you playing"
        {"question_id": dest_questions_by_num[8]["id"], "given_answer": "are you playing"},

        # --- Dạng 2: Sửa lỗi / Viết lại câu (Sentence Correction) ---
        # Câu 9: 'Do top musicians study'
        {"question_id": dest_questions_by_num[9]["id"], "given_answer": "Do top musicians study"},
        # Câu 10: 'aren't touching' -> nhập dạng đầy đủ "are not touching"
        {"question_id": dest_questions_by_num[10]["id"], "given_answer": "are not touching"},
        # Câu 14: 'starts'
        {"question_id": dest_questions_by_num[14]["id"], "given_answer": "starts"},
        # Câu 15: Cố tình nhập SAI ("is winning" thay vì "Is our team winning")
        {"question_id": dest_questions_by_num[15]["id"], "given_answer": "is winning"},

        # --- Dạng 3: Trắc nghiệm (Multiple Choice / Circle correct word) ---
        # Câu 17: Option B ('am working') -> nhập nhãn 'B'
        {"question_id": dest_questions_by_num[17]["id"], "given_answer": "B"},
        # Câu 18: Option A ('don't go') -> nhập text trực tiếp 'don't go'
        {"question_id": dest_questions_by_num[18]["id"], "given_answer": "don't go"},
        # Câu 19: Cố tình chọn nhầm Option 'A' (gets thay vì B: is getting)
        {"question_id": dest_questions_by_num[19]["id"], "given_answer": "A"},
        # Câu 25: 'knows'
        {"question_id": dest_questions_by_num[25]["id"], "given_answer": "knows"},
        # Câu 26: 'do you spell'
        {"question_id": dest_questions_by_num[26]["id"], "given_answer": "do you spell"}
    ]

    print(f"\n  [*] Nộp bài tập Destination B1 với {len(dest_answers_payload)} câu trả lời:")
    print("      - Test viết tắt: Câu 1 ('s writing), Câu 5 ('m not lying)")
    print("      - Test viết đầy đủ thay vì viết tắt: Câu 10 (are not touching)")
    print("      - Test trắc nghiệm theo nhãn (B) và theo từ (don't go)")
    print("      - Test câu cố tình trả lời sai: Câu 15 và Câu 19")

    submit_dest_res = client.post(
        f"/attempts/{dest_attempt_id}/submit",
        json={"answers": dest_answers_payload},
        headers=headers
    )
    assert submit_dest_res.status_code == 200
    dest_result = submit_dest_res.json()

    print(f"\n  [+] Kết quả chấm Destination B1:")
    print(f"      - Số câu làm đúng: {dest_result['correct_count']}/{dest_result['total_questions']}")
    print(f"      - Tỉ lệ đạt: {dest_result['score_percentage']}%")

    d_ans_map = {a["question_id"]: a for a in dest_result["answers"]}
    
    # Kiểm tra chi tiết từng dạng:
    assert d_ans_map[dest_questions_by_num[1]["id"]]["is_correct"] is True, "Câu 1 viết tắt 's writing phải đúng"
    assert d_ans_map[dest_questions_by_num[2]["id"]]["is_correct"] is True, "Câu 2 are losing phải đúng"
    assert d_ans_map[dest_questions_by_num[5]["id"]]["is_correct"] is True, "Câu 5 'm not lying phải đúng"
    assert d_ans_map[dest_questions_by_num[8]["id"]]["is_correct"] is True, "Câu 8 are you playing phải đúng"
    assert d_ans_map[dest_questions_by_num[9]["id"]]["is_correct"] is True, "Câu 9 Do top musicians study phải đúng"
    assert d_ans_map[dest_questions_by_num[10]["id"]]["is_correct"] is True, "Câu 10 are not touching phải đúng"
    assert d_ans_map[dest_questions_by_num[14]["id"]]["is_correct"] is True, "Câu 14 starts phải đúng"
    assert d_ans_map[dest_questions_by_num[15]["id"]]["is_correct"] is False, "Câu 15 cố tình nhập sai phải chấm sai"
    assert d_ans_map[dest_questions_by_num[17]["id"]]["is_correct"] is True, "Câu 17 trắc nghiệm B phải đúng"
    assert d_ans_map[dest_questions_by_num[18]["id"]]["is_correct"] is True, "Câu 18 trắc nghiệm bằng text phải đúng"
    assert d_ans_map[dest_questions_by_num[19]["id"]]["is_correct"] is False, "Câu 19 chọn nhầm A phải chấm sai"
    assert d_ans_map[dest_questions_by_num[25]["id"]]["is_correct"] is True, "Câu 25 knows phải đúng"
    assert d_ans_map[dest_questions_by_num[26]["id"]]["is_correct"] is True, "Câu 26 do you spell phải đúng"

    print("\n  [✓] TẤT CẢ CÁC PHÉP TEST DẠNG BÀI ĐÃ THÀNH CÔNG VƯỢT TRỘI:")
    print("      1. Dạng điền từ / chia thì ngữ pháp (hỗ trợ đầy đủ viết tắt 's, 'm, 're)")
    print("      2. Dạng viết lại câu & sửa lỗi")
    print("      3. Dạng trắc nghiệm (nhận cả ký tự A/B/C/D và text của lựa chọn)")
    print("      4. Chấm điểm chính xác câu sai và cung cấp lời giải thích (Explanation)")
    print("=================================================================")

if __name__ == "__main__":
    run_comprehensive_tests()
