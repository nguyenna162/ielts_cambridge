# IELTS & Grammar Practice Web App (Cambridge IELTS & Destination Series)

Ứng dụng web luyện đề IELTS và Ngữ pháp tiếng Anh chạy độc lập (offline) và mạng LAN nội bộ, phục vụ luyện thi các bộ đề Cambridge IELTS kèm audio và bộ giáo trình Destination B1, B2, C1 & C2 có chấm điểm tự động.

---

## 1. Cấu trúc Dự án

```
ielts-app/
├── backend/
│   ├── app/
│   │   ├── main.py                # FastAPI entrypoint, phục vụ API & nhúng React
│   │   ├── config.py              # Đọc cấu hình từ .env
│   │   ├── db.py                  # SQLAlchemy engine/session
│   │   ├── models/                # SQLAlchemy models (Book, Test, Section, Question...)
│   │   ├── schemas/               # Pydantic schemas
│   │   ├── routers/               # API endpoints (books, tests, sections, audio, attempts, auth)
│   │   ├── services/              # Chấm điểm thông minh, xác thực
│   │   └── static/                # Static frontend build nhúng vào app
│   ├── alembic/versions/          # Migration scripts
│   ├── scripts/
│   │   ├── seed_content.py        # Script nạp/cập nhật DB idempotent
│   │   ├── verify_content.py      # Đối chiếu đủ số câu hỏi/đáp án
│   │   ├── checksum_assets.py     # Tính SHA-256 cho audio/pdf
│   │   └── test_grading_comprehensive.py # Test tự động toàn diện các dạng bài
│   ├── requirements.txt
│   └── build_exe.spec             # Cấu hình đóng gói PyInstaller
├── frontend/                      # Giao diện React + Vite (TypeScript)
├── content/                       # Thư mục dữ liệu sách gốc (9 bộ sách)
│   ├── cambridge-ielts-10/        # Cambridge IELTS 10 (PDF + Audio + Questions)
│   ├── cambridge-ielts-11/        # Cambridge IELTS 11 (PDF + Questions)
│   ├── cambridge-ielts-12/        # Cambridge IELTS 12 (PDF + Questions)
│   ├── cambridge-ielts-13/        # Cambridge IELTS 13 (PDF + Audio + Questions)
│   ├── cambridge-ielts-14/        # Cambridge IELTS 14 (PDF + Questions)
│   ├── cambridge-ielts-15/        # Cambridge IELTS 15 (PDF + Audio + Questions)
│   ├── destination-b1/            # Destination B1 Grammar & Vocabulary
│   ├── destination-b2/            # Destination B2 Grammar & Vocabulary
│   └── destination-c1-c2/         # Destination C1 & C2 Grammar & Vocabulary
├── release/                       # Thư mục đóng gói phân phối sang máy LAN (v1.1.0)
│   ├── ielts-app.exe              # File thực thi độc lập (đã nhúng backend + frontend)
│   ├── ielts_db_v1.1.0.dump       # Bản dump PostgreSQL binary format đầy đủ 9 sách
│   ├── ielts_db_v1.1.0.sql        # Bản dump PostgreSQL plain SQL format
│   ├── content/                   # Toàn bộ nội dung sách và media phân phối kèm
│   ├── .env.example               # Mẫu cấu hình môi trường
│   └── .env                       # File cấu hình kết nối DB
├── .gitattributes                 # Cấu hình Git LFS cho *.exe, *.mp3, *.m4a, *.pdf, *.dump
└── README.md                      # Tài liệu duy nhất của dự án
```

---

## 2. Danh mục Sách & Chương trình Luyện tập

1. **Bộ Cambridge IELTS (Academic)**:
   - **Cambridge IELTS 10, 11, 12, 13, 14, 15**: Đầy đủ các bài Listening & Reading với giao diện thi mô phỏng, phát audio trực tiếp, chia đôi màn hình đọc và điều hướng câu hỏi.
2. **Bộ Destination (Grammar & Vocabulary)**:
   - **Destination B1**: Luyện tập ngữ pháp & từ vựng trung cấp (Chia thì, viết lại câu, khoanh từ đúng).
   - **Destination B2**: Luyện tập ngữ pháp nâng cao (Hiện tại hoàn thành tiếp diễn, viết lại câu, điền khung từ vựng).
   - **Destination C1 & C2**: Luyện tập ngữ pháp chuyên sâu (Đảo ngữ, thể giả định, phân biệt thì tinh tế).

---

## 3. Hướng dẫn Phát triển trên máy DEV (Development)

### Yêu cầu môi trường:
- Python 3.12+ / 3.13+
- Node.js 18+
- PostgreSQL 14+ (khuyến nghị 18)

### Cài đặt & Khởi chạy:
1. **Cài đặt thư viện backend**:
   ```bash
   cd backend
   pip install -r requirements.txt
   ```
2. **Cấu hình file `backend/.env`**:
   ```ini
   DATABASE_URL=postgresql+psycopg://admin:1@localhost:5432/Cambridge_ielts
   SECRET_KEY=dev_secret_key_ielts_app_change_in_production
   CONTENT_DIR=../content
   PORT=8000
   ```
3. **Chạy Migration & Nạp dữ liệu**:
   ```bash
   # Tạo bảng
   cd backend && alembic upgrade head

   # Nạp dữ liệu toàn bộ các sách
   python scripts/seed_content.py --all

   # Xác minh tính toàn vẹn 100% câu hỏi có đáp án
   python scripts/verify_content.py --all

   # Chạy test tự động chấm điểm & nộp bài
   python scripts/test_grading_comprehensive.py
   ```
4. **Chạy web dev server**:
   - Backend: `uvicorn app.main:app --reload --port 8000`
   - Frontend: `cd frontend && npm run dev`

---

## 4. Hướng dẫn Triển khai ở Mạng LAN / Máy Offline (Release v1.1.0)

Toàn bộ gói sản phẩm chuyển giao đã được đóng gói sẵn trong thư mục `release/`.

### Bước 1: Cài đặt PostgreSQL trên máy LAN
Cài đặt PostgreSQL trên máy chủ nội bộ.

### Bước 2: Tạo Database & Restore Dữ liệu
Mở Command Prompt / PowerShell:

```bash
# Tạo database trống
createdb -U admin Cambridge_ielts

# Restore bằng file dump nhị phân (khuyến nghị)
pg_restore -h localhost -U admin -d Cambridge_ielts -c release/ielts_db_v1.1.0.dump

# HOẶC restore bằng file SQL thông thường
psql -h localhost -U admin -d Cambridge_ielts -f release/ielts_db_v1.1.0.sql
```

### Bước 3: Cấu hình file `.env`
Trong thư mục `release/`, cấu hình file `.env` cạnh file `ielts-app.exe`:

```ini
DATABASE_URL=postgresql+psycopg://admin:mat_khau_db@localhost:5432/Cambridge_ielts
SECRET_KEY=khoa_bao_mat_tuy_chon
HOST=0.0.0.0
PORT=8000
CONTENT_DIR=content
```

### Bước 4: Khởi chạy ứng dụng
Chạy trực tiếp file exe:
```bash
.\release\ielts-app.exe
```

Truy cập trên trình duyệt web:
- Trên máy chủ: `http://localhost:8000`
- Trong mạng LAN: `http://<IP_MAY_CHU>:8000` (ví dụ: `http://192.168.1.100:8000`)

---

## 5. Tài khoản Đăng nhập Mặc định

- **Tài khoản Học viên**: `student` / mật khẩu: `123456`
- **Tài khoản Quản trị**: `admin` / mật khẩu: `1`

---

## 6. Lưu ý Quan trọng khi Triển khai Offline / Mạng LAN

> [!IMPORTANT]
> 1. **Git LFS & File Audio/PDF**: Toàn bộ file media (`.mp3`, `.m4a`) và tài liệu (`.pdf`) được quản lý bằng Git LFS. Nếu máy LAN **không có internet**, hãy copy trực tiếp thư mục `release/` (đặc biệt là `release/content/`) qua USB hoặc thư mục chia sẻ mạng nội bộ.
> 2. **Không phụ thuộc CDN**: File `ielts-app.exe` đã được nhúng sẵn 100% font chữ, icon, giao diện React, hoàn toàn không gọi bất kỳ domain hay dịch vụ ngoài nào lúc chạy.
