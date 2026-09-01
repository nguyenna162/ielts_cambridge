import os
import sys

# Add backend directory to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_api():
    print("[*] Testing /healthz...")
    r = client.get("/healthz")
    assert r.status_code == 200, f"Healthz failed: {r.text}"
    print("    [+] /healthz status: OK")

    print("[*] Testing /auth/login...")
    r = client.post("/auth/login", json={"username": "admin", "password": "1"})
    assert r.status_code == 200, f"Login failed: {r.text}"
    token = r.json()["access_token"]
    headers = {"Authorization": f"Bearer {token}"}
    print(f"    [+] Login OK, token received: {token[:20]}...")

    print("[*] Testing /books...")
    r = client.get("/books", headers=headers)
    assert r.status_code == 200, f"Get books failed: {r.text}"
    books = r.json()
    assert len(books) >= 1, "No books found"
    book_id = books[0]["id"]
    print(f"    [+] Found {len(books)} books. First book: '{books[0]['title']}' (ID: {book_id})")

    print(f"[*] Testing /books/{book_id}/tests...")
    r = client.get(f"/books/{book_id}/tests", headers=headers)
    assert r.status_code == 200
    tests = r.json()
    assert len(tests) == 4, f"Expected 4 tests, got {len(tests)}"
    print(f"    [+] Found 4 tests for book {book_id}")

    test_id = tests[0]["id"]
    print(f"[*] Testing /tests/{test_id}/sections...")
    r = client.get(f"/tests/{test_id}/sections", headers=headers)
    assert r.status_code == 200
    sections = r.json()
    print(f"    [+] Found {len(sections)} sections in Test 1")

    section_id = sections[0]["id"]
    print(f"[*] Testing /sections/{section_id} (detail)...")
    r = client.get(f"/sections/{section_id}", headers=headers)
    assert r.status_code == 200
    sec_data = r.json()
    q_count = sum(len(g["questions"]) for g in sec_data["question_groups"])
    print(f"    [+] Section {section_id} skill: {sec_data['skill']}, questions: {q_count}")

    print("[*] Testing /attempts and grading flow...")
    r = client.post("/attempts", json={"section_id": section_id}, headers=headers)
    assert r.status_code == 200
    attempt_id = r.json()["id"]

    # Submit sample answers
    first_q = sec_data["question_groups"][0]["questions"][0]
    submit_payload = {
        "answers": [
            {"question_id": first_q["id"], "given_answer": "Jamieson"}
        ]
    }
    r = client.post(f"/attempts/{attempt_id}/submit", json=submit_payload, headers=headers)
    assert r.status_code == 200
    result = r.json()
    assert result["correct_count"] == 1
    print(f"    [+] Attempt submitted successfully! Score: {result['correct_count']}/{result['total_questions']} ({result['score_percentage']}%)")

    print("[+] ALL API ENDPOINT TESTS PASSED SUCCESSFULLY!")

if __name__ == "__main__":
    test_api()
