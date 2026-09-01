import argparse
import hashlib
import os
import sys
from pathlib import Path

# Add backend directory to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from sqlalchemy import select, update
from app.db import SessionLocal
from app.models import Book, AudioTrack, Section


def calculate_sha256(file_path: Path) -> str:
    hasher = hashlib.sha256()
    with open(file_path, "rb") as f:
        while chunk := f.read(65536):
            hasher.update(chunk)
    return hasher.hexdigest()


def process_book_assets(book_dir: Path, db_session, out_lines: list) -> dict:
    checksums = {}
    print(f"[*] Processing assets in: {book_dir}")

    # Check source PDF
    source_dir = book_dir / "source"
    if source_dir.exists():
        for pdf_file in source_dir.glob("*.pdf"):
            rel_path = f"{book_dir.name}/source/{pdf_file.name}"
            csum = calculate_sha256(pdf_file)
            checksums[rel_path] = csum
            out_lines.append(f"{csum}  {rel_path}")
            print(f"  [PDF] {rel_path}: {csum}")

            # Update in DB if book exists
            if db_session:
                stmt = (
                    update(Book)
                    .where(Book.source_pdf_path.like(f"%{pdf_file.name}%"))
                    .values(source_pdf_checksum=csum)
                )
                db_session.execute(stmt)

    # Check audio files
    audio_dir = book_dir / "audio"
    if audio_dir.exists():
        for audio_file in sorted(audio_dir.glob("*.*")):
            if audio_file.suffix.lower() in [".mp3", ".m4a", ".wav", ".ogg"]:
                rel_path = f"{book_dir.name}/audio/{audio_file.name}"
                csum = calculate_sha256(audio_file)
                checksums[rel_path] = csum
                out_lines.append(f"{csum}  {rel_path}")
                print(f"  [Audio] {rel_path}: {csum}")

                # Update in DB if audio track exists
                if db_session:
                    stmt = (
                        update(AudioTrack)
                        .where(AudioTrack.file_path.like(f"%{audio_file.name}%"))
                        .values(checksum=csum)
                    )
                    db_session.execute(stmt)

    if db_session:
        db_session.commit()

    return checksums


def main():
    parser = argparse.ArgumentParser(description="Calculate SHA-256 for assets and update DB")
    parser.add_argument("--book", type=str, help="Path to book directory or questions_seed.json")
    parser.add_argument("--all", action="store_true", help="Process all books in content directory")
    parser.add_argument("--out", type=str, help="Output checksums file path")
    args = parser.parse_args()

    content_dir = Path(__file__).resolve().parent.parent.parent / "content"
    book_dirs = []

    if args.book:
        p = Path(args.book)
        if not p.is_absolute():
            p = (Path.cwd() / p).resolve()
        if p.is_file():
            # If questions_seed.json passed, find parent book dir
            if p.parent.name == "data":
                book_dirs.append(p.parent.parent)
            else:
                book_dirs.append(p.parent)
        elif p.is_dir():
            book_dirs.append(p)
    elif args.all:
        if content_dir.exists():
            for child in sorted(content_dir.iterdir()):
                if child.is_dir() and (child / "source").exists():
                    book_dirs.append(child)
    else:
        parser.print_help()
        sys.exit(1)

    if not book_dirs:
        print("No valid book directories found.")
        sys.exit(0)

    db_session = None
    try:
        db_session = SessionLocal()
    except Exception as e:
        print(f"[!] Could not connect to DB for updating checksums: {e}")

    out_lines = []
    for b_dir in book_dirs:
        process_book_assets(b_dir, db_session, out_lines)

    if db_session:
        db_session.close()

    if args.out:
        out_path = Path(args.out)
        if not out_path.is_absolute():
            out_path = Path.cwd() / out_path
        out_path.parent.mkdir(parents=True, exist_ok=True)
        with open(out_path, "w", encoding="utf-8") as f:
            f.write("\n".join(out_lines) + "\n")
        print(f"\n[+] Checksums written to {out_path}")
    else:
        # Default write to each book folder
        for b_dir in book_dirs:
            book_csums = [l for l in out_lines if f"{b_dir.name}/" in l]
            if book_csums:
                book_out = b_dir / "checksums.txt"
                with open(book_out, "w", encoding="utf-8") as f:
                    f.write("\n".join(book_csums) + "\n")
                print(f"[+] Book checksums written to {book_out}")


if __name__ == "__main__":
    main()
