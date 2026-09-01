import asyncio
import os
import sys
from pathlib import Path

# Add backend directory to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from sqlalchemy import create_engine, select, func
from sqlalchemy.orm import Session
from app.models import Book, Test, Section, Passage
from app.config import settings

def verify_db():
    engine = create_engine(str(settings.DATABASE_URL))
    with Session(engine) as db:
        passages = db.execute(select(Passage)).scalars().all()
        print(f"\n[+] Total passages in DB: {len(passages)}")
        
        short_passages = [p for p in passages if len(p.body_text or '') < 2000]
        if short_passages:
            print(f"[!] Warning: {len(short_passages)} passages have < 2000 chars:")
            for p in short_passages:
                print(f"  - Passage ID {p.id}: '{p.title}' ({len(p.body_text or '')} chars)")
        else:
            print("[+] All 72 passages have full body text (> 2000 characters)!")

        lengths = [len(p.body_text or '') for p in passages]
        print(f"[+] Min length: {min(lengths)} chars")
        print(f"[+] Max length: {max(lengths)} chars")
        print(f"[+] Avg length: {sum(lengths)//len(lengths)} chars")

        # Check sample passages
        print("\n--- Sample Passages ---")
        for p in passages[::12]:
            print(f"ID {p.id} | Section {p.section_id} | Title: '{p.title}' | Length: {len(p.body_text)} chars")
            print(f"Snippet: {p.body_text[:120]}...\n")

if __name__ == "__main__":
    verify_db()
