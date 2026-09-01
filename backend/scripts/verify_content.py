import argparse
import os
import sys
from pathlib import Path

# Add backend directory to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from sqlalchemy import select
from app.db import SessionLocal
from app.models import (
    Book,
    Test,
    Section,
    AudioTrack,
    QuestionGroup,
    Question,
    AnswerKey,
)


def verify_book_content(book_id: int, db) -> bool:
    book = db.get(Book, book_id)
    if not book:
        print(f"[!] Book with ID {book_id} not found.")
        return False

    print(f"\n=======================================================")
    print(f"[*] Verifying Content Integrity for Book: '{book.title}' (ID: {book.id})")
    print(f"=======================================================")

    is_valid = True
    total_groups = 0
    total_questions = 0
    total_answers = 0
    missing_questions = []
    missing_answers = []
    missing_audio = []

    tests = db.execute(
        select(Test).where(Test.book_id == book.id).order_by(Test.test_number)
    ).scalars().all()

    if not tests:
        print("  [!] Warning: Book has no tests recorded.")
        return False

    for test in tests:
        sections = db.execute(
            select(Section)
            .where(Section.test_id == test.id)
            .order_by(Section.skill, Section.part_number)
        ).scalars().all()

        for section in sections:
            # Check audio for listening sections
            if section.skill == "listening":
                audio = db.execute(
                    select(AudioTrack).where(AudioTrack.section_id == section.id)
                ).scalar_one_or_none()

                if not audio:
                    missing_audio.append(
                        f"Test {test.test_number} - {section.skill} Part {section.part_number}: No audio track in DB"
                    )
                else:
                    audio_path = Path(__file__).resolve().parent.parent.parent / "content" / audio.file_path
                    if not audio_path.exists():
                        # Try relative to content dir
                        audio_path = Path(__file__).resolve().parent.parent.parent / audio.file_path
                    if not audio_path.exists():
                        missing_audio.append(
                            f"Test {test.test_number} - {section.skill} Part {section.part_number}: Audio file not found ({audio.file_path})"
                        )

            # Check question groups
            groups = db.execute(
                select(QuestionGroup)
                .where(QuestionGroup.section_id == section.id)
                .order_by(QuestionGroup.group_order)
            ).scalars().all()

            for grp in groups:
                total_groups += 1
                expected_count = grp.question_to - grp.question_from + 1

                questions = db.execute(
                    select(Question)
                    .where(Question.group_id == grp.id)
                    .order_by(Question.question_number)
                ).scalars().all()

                actual_count = len(questions)
                total_questions += actual_count

                if actual_count != expected_count:
                    is_valid = False
                    existing_nums = {q.question_number for q in questions}
                    expected_nums = set(range(grp.question_from, grp.question_to + 1))
                    missing_nums = sorted(list(expected_nums - existing_nums))
                    missing_questions.append(
                        f"Test {test.test_number} [{section.skill} P{section.part_number}] Group {grp.group_order} ({grp.question_from}-{grp.question_to}): Expected {expected_count} questions, found {actual_count}. Missing Qs: {missing_nums}"
                    )

                # Check answer keys for each question
                for q in questions:
                    ans = db.execute(
                        select(AnswerKey).where(AnswerKey.question_id == q.id)
                    ).scalar_one_or_none()

                    if not ans or not ans.correct_answer:
                        is_valid = False
                        missing_answers.append(
                            f"Test {test.test_number} [{section.skill} P{section.part_number}] Q{q.question_number}: Missing answer key"
                        )
                    else:
                        total_answers += 1

    print(f"\n--- Verification Statistics ---")
    print(f"Total Tests:            {len(tests)}")
    print(f"Total Question Groups:  {total_groups}")
    print(f"Total Questions:        {total_questions}")
    print(f"Total Answer Keys:      {total_answers}")

    if missing_audio:
        print(f"\n[!] Audio Issues ({len(missing_audio)}):")
        for err in missing_audio:
            print(f"    - {err}")

    if missing_questions:
        print(f"\n[!] Missing Questions ({len(missing_questions)}):")
        for err in missing_questions:
            print(f"    - {err}")

    if missing_answers:
        print(f"\n[!] Missing Answer Keys ({len(missing_answers)}):")
        for err in missing_answers:
            print(f"    - {err}")

    if is_valid and not missing_questions and not missing_answers:
        print(f"\n[+] SUCCESS: Book '{book.title}' is 100% complete and verified with all answer keys!")
        return True
    else:
        print(f"\n[-] FAILED: Integrity issues found in '{book.title}'. Please update questions_seed.json and re-run seed_content.py.")
        return False


def main():
    parser = argparse.ArgumentParser(description="Verify IELTS question and answer integrity")
    parser.add_argument("--book", type=str, help="Book title, directory path, or ID")
    parser.add_argument("--all", action="store_true", help="Verify all books in database")
    args = parser.parse_args()

    db = SessionLocal()
    try:
        if args.book:
            # Check if book is ID, title, or directory
            book = None
            if args.book.isdigit():
                book = db.get(Book, int(args.book))
            else:
                p = Path(args.book)
                if p.name == "data":
                    p = p.parent
                slug = p.name.replace("-", " ").replace("_", " ")
                # Try finding by title match
                stmt = select(Book).where(Book.title.ilike(f"%{slug}%"))
                book = db.execute(stmt).scalars().first()
                if not book:
                    stmt = select(Book).where(Book.title == args.book)
                    book = db.execute(stmt).scalars().first()

            if not book:
                print(f"[!] Could not find book matching '{args.book}' in database.")
                sys.exit(1)

            valid = verify_book_content(book.id, db)
            sys.exit(0 if valid else 1)

        elif args.all:
            books = db.execute(select(Book).order_by(Book.id)).scalars().all()
            if not books:
                print("[!] No books found in database to verify.")
                sys.exit(0)

            all_ok = True
            for b in books:
                ok = verify_book_content(b.id, db)
                if not ok:
                    all_ok = False

            sys.exit(0 if all_ok else 1)
        else:
            parser.print_help()
            sys.exit(1)
    finally:
        db.close()


if __name__ == "__main__":
    main()
