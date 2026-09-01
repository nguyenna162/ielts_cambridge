import os
import sys
from pathlib import Path

# Add backend directory to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse

from app.config import settings
from app.routers import auth, books, tests, sections, audio, attempts, admin

app = FastAPI(
    title="IELTS Practice API",
    description="Backend API for Cambridge IELTS Practice & Testing System",
    version="1.0.0",
)

# CORS middleware for dev mode and frontend integration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include API routers
app.include_router(auth.router)
app.include_router(books.router)
app.include_router(tests.router)
app.include_router(sections.router)
app.include_router(audio.router)
app.include_router(attempts.router)
app.include_router(admin.router)


@app.get("/healthz", tags=["Health"])
def health_check():
    return {"status": "ok", "version": "1.0.0"}


# Resolve static directory (supports frozen PyInstaller and dev mode)
if getattr(sys, "frozen", False) and hasattr(sys, "_MEIPASS"):
    static_dir = Path(sys._MEIPASS) / "app" / "static"
else:
    static_dir = Path(__file__).resolve().parent / "static"

if (static_dir / "assets").exists():
    app.mount("/assets", StaticFiles(directory=static_dir / "assets"), name="assets")

@app.get("/{full_path:path}")
def serve_frontend_spa(full_path: str):
    file_path = static_dir / full_path
    if file_path.exists() and file_path.is_file():
        return FileResponse(file_path)
    index_file = static_dir / "index.html"
    if index_file.exists():
        return FileResponse(index_file)
    return {"message": "Frontend not built yet. Access /docs for API documentation."}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host=settings.HOST, port=settings.PORT)
