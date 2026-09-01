# INSTRUCTIONS — Xây dựng DB & Web App IELTS Practice (Cambridge IELTS 15)
# Phạm vi: TOÀN BỘ thao tác dưới đây chạy trên MÁY DEV (có internet).
# Máy LAN là máy khác, người dùng tự triển khai riêng — KHÔNG bao gồm trong file này.
# Agent chỉ cần đảm bảo sản phẩm cuối (DB dump + exe) tương thích để chuyển sang LAN sau này.

## 0. MỤC TIÊU

Trên máy DEV, xây dựng hoàn chỉnh:
1. Database PostgreSQL 18 chứa dữ liệu bài tập của **nhiều cuốn sách Cambridge IELTS** (hiện có ~10 cuốn, ví dụ Cambridge IELTS 15, 16..., mỗi cuốn ~147 trang kèm ~15 file audio), có khả năng **thêm/cập nhật cuốn sách mới bằng script** khi có tài liệu mới, không cần sửa tay DB.
2. Web app (backend Python + frontend React) cho phép làm bài luyện đề, có chấm điểm.
3. Đóng gói kết quả thành: 1 file backend exe độc lập + 1 file DB dump hoàn chỉnh + thư mục nội dung (audio/pdf) — sẵn sàng để đưa sang máy LAN khác qua Git private (việc đưa sang & vận hành ở LAN do người dùng tự làm).

## 1. RÀNG BUỘC THIẾT KẾ CẦN TUÂN THỦ (đơn giản, không cần bảo mật phức tạp)

Web này phục vụ rất ít người dùng trong mạng LAN nội bộ đã được bảo mật ở tầng hạ tầng/chính sách doanh nghiệp, nên **không cần đầu tư vào bảo mật ứng dụng phức tạp** (không cần JWT nâng cao, không cần rate limiting, không cần ẩn giấu đáp án cầu kỳ, không cần phân quyền chi tiết). Ưu tiên hàng đầu là **đơn giản, dễ code, dễ bảo trì, chạy ổn định**.

Chỉ cần giữ 2 ràng buộc kỹ thuật sau vì liên quan đến khả năng chạy được ở môi trường LAN không internet sau này:

- KHÔNG dùng CDN cho font/icon/thư viện trong runtime — cài qua `pip`/`npm` và bundle vào build, vì LAN không có internet để tải lúc chạy.
- KHÔNG dùng Docker.

Về dữ liệu, chỉ cần lưu ý: bảng `users`/`user_attempts`/`user_answers` (dữ liệu người dùng phát sinh khi dùng thật) không cần có data mẫu khi tạo dump chuyển giao — còn lại không cần quy trình tách bạch phức tạp gì thêm, vì đây không phải trọng tâm của bản đơn giản này.

Backend đọc cấu hình kết nối DB (host/user/password/dbname) từ file `.env` đơn giản, không hardcode, để sau này đổi thông số kết nối cho máy LAN không cần build lại.

## 2. TECH STACK

- **Backend**: Python 3.12, FastAPI + SQLAlchemy 2.0 + Alembic (migration).
- **Database**: PostgreSQL 18.
- **Frontend**: React (Vite), build ra static files để backend tự serve (không cần Node.js runtime lúc chạy).
- **Đóng gói**: PyInstaller → 1 file exe/binary chứa cả backend lẫn frontend build sẵn.

## 2b. KẾT NỐI DATABASE (DB đã được tạo sẵn trên máy DEV)

DB đã được tạo sẵn qua pgAdmin trên máy DEV: tên DB `Cambridge_ielts`, user `admin`, password `1`, chạy trên PostgreSQL 18 local (`localhost:5432`).

Lưu ý: PostgreSQL mặc định **tự động chuyển tên không đặt trong dấu ngoặc kép thành chữ thường**. Nếu lúc tạo DB trong pgAdmin bạn gõ tên có chữ hoa (`Cambridge_ielts`) mà không bọc trong `"..."`, thực tế DB có thể đã được lưu là `cambridge_ielts` (chữ thường). Agent cần verify lại tên chính xác bằng lệnh sau trước khi cấu hình kết nối:
```bash
psql -U admin -h localhost -l
# hoặc trong psql:
\l
```
Dùng đúng tên xuất hiện trong danh sách đó (có thể cần bọc `"Cambridge_ielts"` trong connection string nếu tên có chữ hoa).

File `backend/.env` (KHÔNG commit file `.env` thật lên Git — chỉ commit `.env.example`):
```
DATABASE_URL=postgresql+psycopg://admin:1@localhost:5432/Cambridge_ielts
```
Nếu verify ở trên cho thấy tên thực tế là chữ thường, đổi thành:
```
DATABASE_URL=postgresql+psycopg://admin:1@localhost:5432/cambridge_ielts
```

`backend/app/config.py` đọc `DATABASE_URL` từ `.env` (dùng `pydantic-settings` hoặc `python-dotenv`), không hardcode chuỗi kết nối trong code.

Lưu ý bảo mật nhẹ: password `1` chỉ chấp nhận được vì đây là máy DEV cá nhân, không public. Khi đóng gói `.env` mẫu để chuyển giao sang LAN sau này, nhắc người triển khai **đổi sang mật khẩu khác mạnh hơn** cho DB ở LAN — ghi chú này vào README, không cần agent tự ép buộc đổi password lúc code trên DEV.


## 3. CẤU TRÚC REPO (trên máy DEV)

```
ielts-app/
├── backend/
│   ├── app/
│   │   ├── main.py                # FastAPI entrypoint, mount static React build
│   │   ├── config.py              # đọc config từ .env/config.ini, KHÔNG hardcode secrets
│   │   ├── db.py                  # SQLAlchemy engine/session
│   │   ├── models/                # SQLAlchemy models theo schema mục 5
│   │   ├── schemas/                # Pydantic schemas
│   │   ├── routers/                # API: books, tests, sections, questions, audio, attempts, auth
│   │   ├── services/                # logic chấm điểm, xử lý audio_start_sec...
│   │   └── static/                 # copy dist/ của frontend vào đây trước khi build exe
│   ├── alembic/versions/           # migration scripts đánh số tuần tự
│   ├── scripts/
│   │   ├── seed_content.py         # SCRIPT UPDATE DB — xem chi tiết mục 6, chạy lại được nhiều lần an toàn
│   │   ├── verify_content.py       # đối chiếu đủ số câu hỏi/đáp án theo từng group, cho 1 cuốn hoặc tất cả
│   │   └── checksum_assets.py      # tính SHA-256 cho audio/pdf, ghi vào DB + file checksums.txt
│   ├── requirements.txt
│   └── build_exe.spec              # PyInstaller spec
├── frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── vite.config.ts
├── content/                         # dữ liệu gốc, nguồn chân lý — 1 thư mục con cho mỗi cuốn sách
│   ├── cambridge-ielts-15/
│   │   ├── source/book.pdf
│   │   ├── audio/*.mp3             # đặt tên rõ: test{N}_part{M}.mp3
│   │   └── data/questions_seed.json
│   ├── cambridge-ielts-16/
│   │   ├── source/book.pdf
│   │   ├── audio/*.mp3
│   │   └── data/questions_seed.json
│   └── ...                          # tương tự cho các cuốn Cambridge IELTS còn lại (đến 17-18 cuốn)
├── release/                         # output cuối cùng để chuyển giao (build ra, không code tay ở đây)
│   ├── ielts-app.exe
│   ├── ielts_db_vX.Y.Z.dump
│   └── content/                    # copy từ content/, kèm checksums.txt
├── .gitattributes                  # Git LFS cho *.exe *.mp3 *.pdf *.dump
└── README.md
```

## 4. NGUYÊN TẮC LƯU FILE AUDIO/PDF

- KHÔNG lưu file audio/pdf dạng BLOB trong PostgreSQL — DB chỉ lưu `file_path` (đường dẫn tương đối) + `checksum` SHA-256.
- File gốc trong `content/source/` và `content/audio/` coi là **read-only** sau khi seed — mọi xử lý phái sinh (cắt ảnh trang, cắt audio theo câu) tạo file mới, không ghi đè bản gốc.
- `checksum_assets.py` phải chạy sau mỗi lần thêm/sửa file, ghi checksum vào bảng tương ứng và xuất `checksums.txt` để dùng đối chiếu sau này.

## 5. DATABASE SCHEMA (PostgreSQL 18) — Alembic phải tạo đúng theo đây

```sql
CREATE TABLE books (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT NOT NULL,
    total_pages INT,
    source_pdf_path TEXT NOT NULL,
    source_pdf_checksum TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE tests (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id INT REFERENCES books(id) ON DELETE CASCADE,
    test_number INT NOT NULL,
    UNIQUE(book_id, test_number)
);

CREATE TABLE sections (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    test_id INT REFERENCES tests(id) ON DELETE CASCADE,
    skill TEXT NOT NULL CHECK (skill IN ('listening','reading','writing','speaking')),
    part_number INT NOT NULL,
    page_start INT,
    page_end INT,
    UNIQUE(test_id, skill, part_number)
);

CREATE TABLE audio_tracks (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    section_id INT REFERENCES sections(id) ON DELETE CASCADE UNIQUE,
    file_path TEXT NOT NULL,
    checksum TEXT NOT NULL,
    duration_seconds NUMERIC
);

CREATE TABLE passages (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    section_id INT REFERENCES sections(id) ON DELETE CASCADE,
    title TEXT,
    body_text TEXT
);

CREATE TABLE question_groups (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    section_id INT REFERENCES sections(id) ON DELETE CASCADE,
    group_order INT NOT NULL,
    question_type TEXT NOT NULL,
    instruction TEXT,
    question_from INT NOT NULL,
    question_to INT NOT NULL
);

CREATE TABLE questions (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    group_id INT REFERENCES question_groups(id) ON DELETE CASCADE,
    question_number INT NOT NULL,
    prompt_text TEXT,
    audio_start_sec NUMERIC,
    audio_end_sec NUMERIC,
    page_reference INT,
    UNIQUE(group_id, question_number)
);

CREATE TABLE question_options (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    question_id INT REFERENCES questions(id) ON DELETE CASCADE,
    option_label TEXT,
    option_text TEXT
);

CREATE TABLE answer_keys (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    question_id INT REFERENCES questions(id) ON DELETE CASCADE UNIQUE,
    correct_answer JSONB NOT NULL,   -- mảng các đáp án chấp nhận được
    explanation TEXT
);

-- Bảng người dùng — đơn giản, số lượng user rất ít, tạo thủ công qua script hoặc admin UI
CREATE TABLE users (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    is_admin BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE user_attempts (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    section_id INT REFERENCES sections(id),
    started_at TIMESTAMPTZ DEFAULT now(),
    finished_at TIMESTAMPTZ
);

CREATE TABLE user_answers (
    id GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    attempt_id INT REFERENCES user_attempts(id) ON DELETE CASCADE,
    question_id INT REFERENCES questions(id),
    given_answer TEXT,
    is_correct BOOLEAN
);
```

Không cần bảng audit log riêng — vì web đơn giản, ít người dùng, sửa nội dung trực tiếp là đủ (nếu sau này cần truy vết thì thêm sau, không phải làm ngay từ đầu).

## 6. QUY TRÌNH NHẬP LIỆU & CẬP NHẬT NỘI DUNG BẰNG SCRIPT (quan trọng — dùng cho ~10 cuốn Cambridge IELTS, và các cuốn mới sau này)

Vì có nhiều cuốn sách (hiện ~10 cuốn, tương lai có thể thêm), **không nhập tay từng lần vào DB** — mọi thao tác thêm/cập nhật nội dung đều đi qua 1 script duy nhất `seed_content.py`, chạy lại được nhiều lần một cách an toàn (idempotent). Quy trình:

1. Với mỗi cuốn sách mới, tạo 1 thư mục riêng trong `content/{book-slug}/` (ví dụ `cambridge-ielts-16/`) theo đúng cấu trúc `source/book.pdf`, `audio/*.mp3`, `data/questions_seed.json` như mục 3 cấu trúc repo.
2. Trích PDF thành ảnh từng trang (`pdftoppm`) để đối chiếu khi soạn câu hỏi, không gõ lại toàn bộ text bằng tay.
3. Soạn `questions_seed.json` cho cuốn đó theo cấu trúc khớp schema mục 5 (book → tests → sections → question_groups → questions → options + đáp án lấy từ trang Answer Keys cuối sách). File JSON là **nguồn dữ liệu duy nhất** — mọi thay đổi nội dung sau này (sửa câu hỏi sai, thêm test mới, cập nhật đáp án) đều sửa trực tiếp trong file JSON này rồi chạy lại script, không sửa tay trong DB qua UI hay SQL thủ công.
4. Chạy `seed_content.py`:
   ```bash
   # Nạp/cập nhật 1 cuốn cụ thể
   python backend/scripts/seed_content.py --book content/cambridge-ielts-16/data/questions_seed.json

   # Hoặc quét toàn bộ content/ và nạp/cập nhật tất cả các cuốn 1 lần
   python backend/scripts/seed_content.py --all
   ```
5. **Yêu cầu kỹ thuật bắt buộc cho `seed_content.py` (agent phải code đúng theo đây):**
   - Dùng khóa tự nhiên (natural key) để xác định 1 bản ghi đã tồn tại hay chưa, thay vì luôn INSERT mới:
     - `books`: khóa theo `title` (ví dụ `"Cambridge IELTS 16"`).
     - `tests`: khóa theo `(book_id, test_number)`.
     - `sections`: khóa theo `(test_id, skill, part_number)`.
     - `question_groups`: khóa theo `(section_id, group_order)`.
     - `questions`: khóa theo `(group_id, question_number)`.
     - `answer_keys`: khóa theo `question_id` (1-1).
   - Với mỗi bản ghi trong JSON: nếu khóa tự nhiên đã tồn tại trong DB → **UPDATE** các trường (nội dung câu hỏi, đáp án, giải thích...) nếu có thay đổi; nếu chưa tồn tại → **INSERT** mới. Dùng `INSERT ... ON CONFLICT (...) DO UPDATE SET ...` của PostgreSQL để làm gọn, hoặc kiểm tra bằng ORM trước khi ghi.
   - Chạy script 2 lần liên tiếp với cùng 1 file JSON không thay đổi phải cho kết quả DB giống hệt nhau (không tạo trùng lặp bản ghi) — đây là tiêu chí bắt buộc để agent tự test trước khi báo hoàn thành.
   - Ghi log rõ ràng ra console: cuốn nào, bao nhiêu bản ghi mới được thêm, bao nhiêu bản ghi được cập nhật, để người dùng biết được thay đổi gì sau mỗi lần chạy.
6. Chạy `verify_content.py` sau khi seed (hỗ trợ chạy cho 1 cuốn hoặc `--all`): kiểm tra mỗi `question_group` có đủ số câu hỏi (`question_to - question_from + 1`), và mỗi `question` có đáp án tương ứng — báo ra danh sách còn thiếu để bổ sung vào file JSON rồi chạy lại `seed_content.py`.
7. Chạy `checksum_assets.py --book content/cambridge-ielts-16` để chốt checksum audio/pdf cho cuốn mới.

**Tóm lại quy trình khi có tài liệu mới (thêm 1 cuốn Cambridge IELTS mới, hoặc sửa nội dung cuốn cũ):**
```
Thêm/sửa file PDF, audio vào content/{book-slug}/
      → Sửa/soạn content/{book-slug}/data/questions_seed.json
      → chạy: python backend/scripts/seed_content.py --book content/{book-slug}/data/questions_seed.json
      → chạy: python backend/scripts/verify_content.py --book content/{book-slug}
      → chạy: python backend/scripts/checksum_assets.py --book content/{book-slug}
```
Toàn bộ chỉ là chạy lại 3 lệnh trên, không cần biết SQL, không cần đụng vào code backend/frontend.

## 7. BACKEND (FastAPI) — API TỐI GIẢN

Web chỉ phục vụ rất ít người dùng trong LAN nội bộ đã được bảo mật ở tầng hạ tầng/chính sách doanh nghiệp, nên **không cần thiết kế phức tạp** (không JWT phức tạp, không refresh token, không rate limiting, không ẩn giấu đáp án cầu kỳ). Ưu tiên đơn giản, dễ code, dễ bảo trì.

- Đăng nhập đơn giản: 1 bảng `users` (username/password), `POST /auth/login` trả session cookie hoặc token đơn giản là đủ, không cần OAuth, không cần phân quyền admin/student phức tạp — mọi user đăng nhập đều có thể vừa làm bài vừa chỉnh sửa nội dung (hoặc nếu muốn tách nhẹ nhàng, chỉ cần 1 cột `is_admin boolean` để ẩn/hiện menu quản lý, không cần enforce quá chặt).
- CRUD nội dung: `GET/POST/PUT/DELETE` cho `books`, `tests`, `sections`, `question_groups`, `questions`, `answer_keys` — code thẳng theo kiểu CRUD cơ bản, không cần audit log, không cần transaction phức tạp cho seed (dùng script seed đơn giản là được).
- Đọc nội dung: `GET /books`, `GET /books/{id}/tests`, `GET /tests/{id}/sections`, `GET /sections/{id}` (có thể trả kèm đáp án hoặc không tùy ý — vì rủi ro lộ đáp án qua DevTools không đáng lo với số ít người dùng nội bộ tin cậy).
- `GET /sections/{id}/audio` — stream file audio.
- Làm bài & chấm điểm: `POST /attempts`, `POST /attempts/{id}/submit` — so khớp `given_answer` với `answer_keys.correct_answer`, chuẩn hóa lowercase/trim cơ bản là đủ. `GET /attempts/{id}/result`, `GET /users/me/attempts` xem lịch sử.
- `GET /healthz`.

Backend serve luôn static frontend build tại route `/`.

## 8. FRONTEND (React + Vite) — ĐƠN GIẢN

- Đăng nhập (form đơn giản, không cần đăng ký công khai — có thể tạo user thủ công qua script/DB vì số người dùng rất ít).
- Trang chọn sách → chọn test → chọn section.
- Trang làm bài: hiển thị câu hỏi theo group kèm `instruction`, player audio HTML5 cho Listening, đồng hồ đếm giờ (tùy chọn, không bắt buộc phức tạp).
- Nộp bài → trang kết quả: điểm tổng, danh sách từng câu đúng/sai, đáp án đúng, giải thích nếu có.
- Trang lịch sử các lần đã làm (tùy chọn, có thể làm sau nếu cần đơn giản hóa hơn nữa).
- Nếu có `is_admin`: thêm 1 trang quản lý nội dung đơn giản (list + form thêm/sửa/xóa cho books/tests/sections/questions/answer_keys), không cần giao diện cầu kỳ, bảng HTML + form cơ bản là đủ.

Không dùng CDN cho font/icon/thư viện — cài qua npm, bundle vào build (vì môi trường LAN đích không có internet). Build ra `frontend/dist/`, copy vào `backend/app/static/` trước khi đóng gói exe.

## 9. ĐÓNG GÓI EXE (PyInstaller, không Docker)

```bash
# Build frontend
cd frontend && npm install && npm run build
cp -r dist/* ../backend/app/static/

# Đóng gói backend
cd ../backend
pip install pyinstaller
pyinstaller build_exe.spec --clean
# output: backend/dist/ielts-app.exe (Windows) hoặc backend/dist/ielts-app (Linux)
```

`build_exe.spec` cần:
- `--onefile`.
- `datas` nhúng `app/static/` (frontend build) vào exe.
- KHÔNG nhúng mật khẩu DB thật — đọc từ `.env`/`config.ini` đặt cạnh exe lúc chạy.

## 10. ĐÓNG GÓI SẢN PHẨM CUỐI ĐỂ CHUYỂN GIAO (chỉ tạo file, KHÔNG thực hiện bước đưa sang LAN)

```bash
mkdir -p release/content
cp backend/dist/ielts-app.exe release/

# Dump toàn bộ DB (đơn giản, không cần tách bảng phức tạp) — bao gồm tất cả các cuốn đã seed
pg_dump -U postgres -Fc ielts_db > release/ielts_db_v1.0.0.dump

# Copy toàn bộ content của tất cả các cuốn sách
cp -r content/* release/content/
python backend/scripts/checksum_assets.py --all --out release/content/checksums.txt
```

Vì có nhiều cuốn sách và nội dung sẽ được cập nhật dần theo thời gian (thêm cuốn mới, sửa lỗi câu hỏi), agent nên đặt tên version release theo ngày hoặc số thứ tự tăng dần (`v1.0.0`, `v1.1.0`...) và trong mô tả release (commit message / tag message) ghi rõ **lần này thêm/cập nhật cuốn sách nào** để dễ theo dõi lịch sử nội dung qua các lần release.

Agent chỉ cần đảm bảo `release/` chứa đủ 3 thành phần độc lập, tự khởi động được ở môi trường khác (exe + dump + content), việc đưa vào Git private / chuyển sang máy LAN và restore là do người dùng tự thực hiện.

## 11. LƯU Ý CẦN GHI TRONG README (để tự triển khai ở LAN sau này)

Agent viết README.md có mục ngắn gọn "Lưu ý khi triển khai ở LAN":

- `ielts_db_vX.Y.Z.dump` là dump từ DB dev, khi restore vào DB LAN trống thì dùng được ngay.
- Cấu hình kết nối DB đọc từ file `.env` cạnh exe — người dùng tự chỉnh thông số cho DB ở máy LAN của họ, không cần build lại exe.
- Vì môi trường LAN không có internet, đảm bảo bản build không phụ thuộc CDN nào (agent tự kiểm tra nhanh trước khi bàn giao).

## 12. CHECKLIST TRƯỚC KHI BÁO "HOÀN THÀNH" TRÊN MÁY DEV

- [ ] DB local trên DEV chạy đúng schema mục 5, seed đầy đủ nội dung cho tất cả các cuốn Cambridge IELTS đã có **kèm đầy đủ đáp án lấy từ trang Answer Keys cuối mỗi cuốn**, `verify_content.py --all` xác nhận 100% câu hỏi có đáp án cho mọi cuốn.
- [ ] `seed_content.py` chạy lại 2 lần liên tiếp với cùng dữ liệu không tạo bản ghi trùng lặp (test idempotency thực tế, không chỉ đọc code).
- [ ] Web app chạy được local (`uvicorn` dev server + `npm run dev`), làm được đầy đủ luồng: đăng nhập → chọn sách → chọn test → làm bài nghe (phát audio đúng file) → nộp bài → thấy điểm & giải thích đúng theo đáp án cuối sách.
- [ ] Chức năng CRUD nội dung (books/tests/sections/questions/answer_keys) hoạt động đúng — không cần phân quyền phức tạp, chỉ cần menu quản lý hiện ra khi `is_admin = true` là đủ.
- [ ] `pyinstaller` build ra đúng 1 file exe chạy được độc lập (test bằng cách tắt kết nối mạng trên máy DEV rồi chạy thử exe, xác nhận không lỗi do thiếu mạng).
- [ ] `dump_content_only.py` xuất ra dump không chứa dữ liệu bảng `users/user_attempts/user_answers` — verify bằng cách restore thử vào 1 DB rỗng khác và query các bảng đó phải trống.
- [ ] Không có Docker file nào trong repo.
- [ ] Không có lệnh gọi domain ngoài nào trong runtime code (grep xác nhận).
- [ ] README.md có đầy đủ mục lưu ý ở phần 11.