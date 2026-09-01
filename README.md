# IELTS Practice Web App (Cambridge IELTS)

Ứng dụng web luyện đề IELTS offline / mạng LAN nội bộ, phục vụ luyện thi các bộ đề Cambridge IELTS kèm audio và chấm điểm tự động.

## 1. Cấu trúc Thư mục

```
ielts-app/
├── backend/
│   ├── app/
│   │   ├── main.py                # FastAPI entrypoint
│   │   ├── config.py              # Đọc cấu hình từ .env
│   │   ├── db.py                  # SQLAlchemy engine/session
│   │   ├── models/                # SQLAlchemy models
│   │   ├── schemas/               # Pydantic schemas
│   │   ├── routers/               # API endpoints
│   │   ├── services/              # Chấm điểm, audio...
│   │   └── static/                # Static frontend build nhúng vào app
│   ├── alembic/versions/          # Migration scripts
│   ├── scripts/
│   │   ├── seed_content.py        # Script nạp/cập nhật DB idempotent
│   │   ├── verify_content.py      # Đối chiếu đủ số câu hỏi/đáp án
│   │   └── checksum_assets.py     # Tính SHA-256 cho audio/pdf
│   ├── requirements.txt
│   └── build_exe.spec             # Cấu hình PyInstaller
├── frontend/                      # Giao diện React + Vite
├── content/                       # Thư mục dữ liệu sách gốc
│   └── cambridge-ielts-15/
├── release/                       # Thư mục đóng gói phân phối
└── README.md
```

## 2. Hướng dẫn Phát triển (Development)

### Yêu cầu:
- Python 3.12+ / 3.13+
- Node.js 18+
- PostgreSQL 18

### Cài đặt:
1. Tạo môi trường ảo & cài đặt thư viện backend:
   ```bash
   cd backend
   pip install -r requirements.txt
   ```
2. Cấu hình file `backend/.env`:
   ```env
   DATABASE_URL=postgresql+psycopg://admin:1@localhost:5432/Cambridge_ielts
   SECRET_KEY=dev_secret_key_ielts_app_change_in_production
   CONTENT_DIR=../content
   PORT=8000
   ```
3. Chạy migration tạo bảng:
   ```bash
   cd backend
   alembic upgrade head
   ```
4. Nạp dữ liệu sách:
   ```bash
   python backend/scripts/seed_content.py --all
   python backend/scripts/verify_content.py --all
   python backend/scripts/checksum_assets.py --all
   ```

## 3. Lưu ý khi triển khai ở LAN

> [!IMPORTANT]
> - `ielts_db_vX.Y.Z.dump` là bản dump hoàn chỉnh từ DB dev. Khi restore vào PostgreSQL trên máy LAN trống thì có thể sử dụng ngay mà không cần migrate lại.
> - Cấu hình kết nối DB được đọc từ file `.env` đặt cạnh file exe — người quản trị tự chỉnh thông số kết nối (`DATABASE_URL`, user/password mạnh hơn) cho phù hợp với môi trường LAN mà không cần build lại exe.
> - Môi trường LAN không có internet — toàn bộ font, icon và thư viện frontend đã được bundle sẵn trong file exe, không phụ thuộc bất kỳ CDN ngoài nào.
