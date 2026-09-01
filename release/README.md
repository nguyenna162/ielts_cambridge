# IELTS Practice App — Release v1.0.0

Stand-alone, offline & LAN-ready Cambridge IELTS Practice Application.

---

## 1. Directory Structure

```
release/
├── ielts-app.exe                  # Standalone application executable
├── .env.example                   # Configuration template
├── ielts_db_v1.0.0.dump          # PostgreSQL binary dump with full Cambridge IELTS 15 data
├── ielts_db_v1.0.0.sql           # PostgreSQL plain SQL dump
├── content/                       # Media and question data
│   └── cambridge-ielts-15/
│       ├── audio/                 # Listening audio tracks (m4a)
│       ├── source/                # Original PDF (book.pdf)
│       ├── data/                  # questions_seed.json
│       └── checksums.txt          # SHA-256 integrity checksums
└── README.md                      # Setup and deployment manual
```

---

## 2. Installation & Setup from Zero

### Step 1: Install PostgreSQL
Ensure PostgreSQL (version 14+) is installed and running on your host/server machine.

### Step 2: Create Database & Restore Data
Open Command Prompt / PowerShell as an administrator or database user:

```bash
# Create database
createdb -U admin Cambridge_ielts

# Restore using binary dump (recommended)
pg_restore -h localhost -U admin -d Cambridge_ielts -c ielts_db_v1.0.0.dump

# OR restore using plain SQL
psql -h localhost -U admin -d Cambridge_ielts -f ielts_db_v1.0.0.sql
```

### Step 3: Configure Environment
Copy `.env.example` to `.env` in the same directory as `ielts-app.exe`:

```bash
copy .env.example .env
```

Edit `.env` to match your PostgreSQL credentials:
```ini
DATABASE_URL=postgresql+psycopg://admin:1@localhost:5432/Cambridge_ielts
SECRET_KEY=your_secret_key_here
HOST=0.0.0.0
PORT=8000
CONTENT_DIR=content
```

### Step 4: Run Application
Double-click `ielts-app.exe` or execute from command line:

```bash
.\ielts-app.exe
```

Access in your browser:
- Localhost: `http://localhost:8000`
- LAN Access: `http://<SERVER_IP>:8000`

---

## 3. User Accounts & Access

- **Student User**: `student` / `123456`
- **Admin User**: `admin` / `1`

---

## 4. Features

- **Realistic IELTS Test Environment**: Part 1-4 Listening with embedded audio player (play/pause, 5s seek, speed controls) and Passage 1-3 Reading with synchronized split view.
- **Instant Automatic Grading**: Accurate scoring matching Cambridge IELTS 15 answer keys with explanation notes.
- **Zero External CDN Dependencies**: 100% offline functionality.
