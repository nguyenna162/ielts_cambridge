import os
import re
import sys
from pathlib import Path
from fastapi import APIRouter, Depends, HTTPException, Request, Response, status
from fastapi.responses import StreamingResponse
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.config import settings
from app.db import get_db
from app.models import AudioTrack

router = APIRouter(prefix="/sections", tags=["Audio"])


def parse_range_header(range_header: str, file_size: int):
    if not range_header:
        return 0, file_size - 1

    match = re.match(r"bytes=(\d+)-(\d*)", range_header)
    if not match:
        return 0, file_size - 1

    start_str, end_str = match.groups()
    start = int(start_str) if start_str else 0
    end = int(end_str) if end_str else file_size - 1
    if end >= file_size:
        end = file_size - 1
    return start, end


def stream_file_range(file_path: Path, start: int, end: int, chunk_size: int = 65536):
    with open(file_path, "rb") as f:
        f.seek(start)
        remaining = end - start + 1
        while remaining > 0:
            read_len = min(remaining, chunk_size)
            data = f.read(read_len)
            if not data:
                break
            remaining -= len(data)
            yield data


def resolve_audio_file(rel_path_str: str) -> Path:
    # Try multiple potential content directories
    candidates = []
    # 1. Configured CONTENT_DIR
    candidates.append(Path(settings.CONTENT_DIR) / rel_path_str)
    # 2. If frozen exe, next to executable
    if getattr(sys, "frozen", False):
        exe_dir = Path(sys.executable).resolve().parent
        candidates.append(exe_dir / "content" / rel_path_str)
        candidates.append(exe_dir / rel_path_str)
    # 3. Workspace content directory
    workspace_content = Path(__file__).resolve().parent.parent.parent.parent / "content" / rel_path_str
    candidates.append(workspace_content)
    # 4. Current working directory
    candidates.append(Path.cwd() / "content" / rel_path_str)
    candidates.append(Path.cwd() / rel_path_str)

    for c in candidates:
        if c.exists() and c.is_file():
            return c
    return candidates[0]


@router.get("/{id}/audio")
def get_section_audio(id: int, request: Request, db: Session = Depends(get_db)):
    stmt = select(AudioTrack).where(AudioTrack.section_id == id)
    audio = db.execute(stmt).scalar_one_or_none()
    if not audio:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="No audio track associated with this section",
        )

    file_path = resolve_audio_file(audio.file_path)
    if not file_path.exists():
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Audio file not found on disk: {audio.file_path}",
        )

    file_size = file_path.stat().st_size
    range_header = request.headers.get("range")

    media_type = "audio/mpeg"
    if file_path.suffix.lower() == ".m4a":
        media_type = "audio/mp4"
    elif file_path.suffix.lower() == ".ogg":
        media_type = "audio/ogg"
    elif file_path.suffix.lower() == ".wav":
        media_type = "audio/wav"

    if range_header:
        start, end = parse_range_header(range_header, file_size)
        content_length = end - start + 1
        headers = {
            "Content-Range": f"bytes {start}-{end}/{file_size}",
            "Accept-Ranges": "bytes",
            "Content-Length": str(content_length),
            "Content-Type": media_type,
        }
        return StreamingResponse(
            stream_file_range(file_path, start, end),
            status_code=status.HTTP_206_PARTIAL_CONTENT,
            headers=headers,
            media_type=media_type,
        )
    else:
        headers = {
            "Accept-Ranges": "bytes",
            "Content-Length": str(file_size),
            "Content-Type": media_type,
        }
        return StreamingResponse(
            stream_file_range(file_path, 0, file_size - 1),
            status_code=status.HTTP_200_OK,
            headers=headers,
            media_type=media_type,
        )
