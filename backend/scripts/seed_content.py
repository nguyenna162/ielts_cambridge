import argparse
import hashlib
import json
import os
import sys
from pathlib import Path
from typing import Dict, Any, List

# Add backend directory to sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from sqlalchemy import select
from app.db import SessionLocal
from app.models import (
    Book,
    Test,
    Section,
    AudioTrack,
    Passage,
    QuestionGroup,
    Question,
    QuestionOption,
    AnswerKey,
)


def calculate_sha256(file_path: Path) -> str:
    if not file_path.exists():
        return ""
    hasher = hashlib.sha256()
    with open(file_path, "rb") as f:
        while chunk := f.read(65536):
            hasher.update(chunk)
    return hasher.hexdigest()


class ContentSeeder:
    def __init__(self, db):
        self.db = db
        self.stats = {
            "books_inserted": 0, "books_updated": 0,
            "tests_inserted": 0, "tests_updated": 0,
            "sections_inserted": 0, "sections_updated": 0,
            "audio_inserted": 0, "audio_updated": 0,
            "passages_inserted": 0, "passages_updated": 0,
            "groups_inserted": 0, "groups_updated": 0,
            "questions_inserted": 0, "questions_updated": 0,
            "options_inserted": 0, "options_updated": 0,
            "answers_inserted": 0, "answers_updated": 0,
        }

    def seed_book_data(self, data: Dict[str, Any], book_dir: Path):
        book_info = data.get("book", {})
        title = book_info.get("title", "").strip()
        if not title:
            raise ValueError("Book title cannot be empty")

        total_pages = book_info.get("total_pages")
        source_pdf_path = book_info.get("source_pdf_path", "")
        source_pdf_checksum = book_info.get("source_pdf_checksum", "")

        # Check PDF checksum on disk if missing or relative
        if not source_pdf_checksum and source_pdf_path:
            pdf_file = book_dir.parent / source_pdf_path if not Path(source_pdf_path).is_absolute() else Path(source_pdf_path)
            if not pdf_file.exists():
                pdf_file = book_dir / "source" / "book.pdf"
            if pdf_file.exists():
                source_pdf_checksum = calculate_sha256(pdf_file)

        # 1. Natural key for books: title
        stmt = select(Book).where(Book.title == title)
        book = self.db.execute(stmt).scalar_one_or_none()

        if book is None:
            book = Book(
                title=title,
                total_pages=total_pages,
                source_pdf_path=source_pdf_path,
                source_pdf_checksum=source_pdf_checksum,
            )
            self.db.add(book)
            self.db.flush()
            self.stats["books_inserted"] += 1
            print(f"  [+] Inserted Book: '{title}' (ID: {book.id})")
        else:
            updated = False
            if book.total_pages != total_pages and total_pages is not None:
                book.total_pages = total_pages
                updated = True
            if book.source_pdf_path != source_pdf_path and source_pdf_path:
                book.source_pdf_path = source_pdf_path
                updated = True
            if book.source_pdf_checksum != source_pdf_checksum and source_pdf_checksum:
                book.source_pdf_checksum = source_pdf_checksum
                updated = True
            if updated:
                self.stats["books_updated"] += 1
                print(f"  [*] Updated Book: '{title}' (ID: {book.id})")
            self.db.flush()

        # 2. Tests
        for test_data in data.get("tests", []):
            test_number = test_data.get("test_number")
            if test_number is None:
                continue

            # Natural key for tests: (book_id, test_number)
            stmt = select(Test).where(
                Test.book_id == book.id, Test.test_number == test_number
            )
            test = self.db.execute(stmt).scalar_one_or_none()

            if test is None:
                test = Test(book_id=book.id, test_number=test_number)
                self.db.add(test)
                self.db.flush()
                self.stats["tests_inserted"] += 1
                print(f"    [+] InsertedTest {test_number} (ID: {test.id})")
            else:
                self.stats["tests_updated"] += 0  # No other fields in Test table

            # 3. Sections
            for sec_data in test_data.get("sections", []):
                skill = sec_data.get("skill", "").lower().strip()
                part_number = sec_data.get("part_number")
                page_start = sec_data.get("page_start")
                page_end = sec_data.get("page_end")

                # Natural key for sections: (test_id, skill, part_number)
                stmt = select(Section).where(
                    Section.test_id == test.id,
                    Section.skill == skill,
                    Section.part_number == part_number,
                )
                section = self.db.execute(stmt).scalar_one_or_none()

                if section is None:
                    section = Section(
                        test_id=test.id,
                        skill=skill,
                        part_number=part_number,
                        page_start=page_start,
                        page_end=page_end,
                    )
                    self.db.add(section)
                    self.db.flush()
                    self.stats["sections_inserted"] += 1
                else:
                    updated = False
                    if section.page_start != page_start:
                        section.page_start = page_start
                        updated = True
                    if section.page_end != page_end:
                        section.page_end = page_end
                        updated = True
                    if updated:
                        self.stats["sections_updated"] += 1
                    self.db.flush()

                # 4. Audio Track (1-1 with section)
                audio_data = sec_data.get("audio")
                if audio_data and audio_data.get("file_path"):
                    audio_path = audio_data.get("file_path")
                    audio_checksum = audio_data.get("checksum", "")
                    duration = audio_data.get("duration_seconds")

                    if not audio_checksum:
                        audio_file = book_dir.parent / audio_path if not Path(audio_path).is_absolute() else Path(audio_path)
                        if audio_file.exists():
                            audio_checksum = calculate_sha256(audio_file)

                    stmt = select(AudioTrack).where(AudioTrack.section_id == section.id)
                    audio_track = self.db.execute(stmt).scalar_one_or_none()

                    if audio_track is None:
                        audio_track = AudioTrack(
                            section_id=section.id,
                            file_path=audio_path,
                            checksum=audio_checksum or "unknown",
                            duration_seconds=duration,
                        )
                        self.db.add(audio_track)
                        self.db.flush()
                        self.stats["audio_inserted"] += 1
                    else:
                        updated = False
                        if audio_track.file_path != audio_path:
                            audio_track.file_path = audio_path
                            updated = True
                        if audio_track.checksum != audio_checksum and audio_checksum:
                            audio_track.checksum = audio_checksum
                            updated = True
                        if duration is not None and audio_track.duration_seconds != duration:
                            audio_track.duration_seconds = duration
                            updated = True
                        if updated:
                            self.stats["audio_updated"] += 1

                # 5. Passages
                passages_data = sec_data.get("passages", [])
                existing_passages = self.db.execute(
                    select(Passage).where(Passage.section_id == section.id).order_by(Passage.id)
                ).scalars().all()

                for p_idx, p_data in enumerate(passages_data):
                    p_title = p_data.get("title")
                    p_body = p_data.get("body_text")

                    if p_idx < len(existing_passages):
                        passage = existing_passages[p_idx]
                        updated = False
                        if passage.title != p_title:
                            passage.title = p_title
                            updated = True
                        if passage.body_text != p_body:
                            passage.body_text = p_body
                            updated = True
                        if updated:
                            self.stats["passages_updated"] += 1
                    else:
                        passage = Passage(
                            section_id=section.id,
                            title=p_title,
                            body_text=p_body,
                        )
                        self.db.add(passage)
                        self.db.flush()
                        self.stats["passages_inserted"] += 1

                # 6. Question Groups
                for grp_data in sec_data.get("question_groups", []):
                    group_order = grp_data.get("group_order", 1)
                    q_type = grp_data.get("question_type", "multiple_choice")
                    instruction = grp_data.get("instruction")
                    q_from = grp_data.get("question_from", 1)
                    q_to = grp_data.get("question_to", 1)

                    # Natural key for question_groups: (section_id, group_order)
                    stmt = select(QuestionGroup).where(
                        QuestionGroup.section_id == section.id,
                        QuestionGroup.group_order == group_order,
                    )
                    group = self.db.execute(stmt).scalar_one_or_none()

                    if group is None:
                        group = QuestionGroup(
                            section_id=section.id,
                            group_order=group_order,
                            question_type=q_type,
                            instruction=instruction,
                            question_from=q_from,
                            question_to=q_to,
                        )
                        self.db.add(group)
                        self.db.flush()
                        self.stats["groups_inserted"] += 1
                    else:
                        updated = False
                        if group.question_type != q_type:
                            group.question_type = q_type
                            updated = True
                        if group.instruction != instruction:
                            group.instruction = instruction
                            updated = True
                        if group.question_from != q_from:
                            group.question_from = q_from
                            updated = True
                        if group.question_to != q_to:
                            group.question_to = q_to
                            updated = True
                        if updated:
                            self.stats["groups_updated"] += 1
                        self.db.flush()

                    # 7. Questions
                    for q_data in grp_data.get("questions", []):
                        q_num = q_data.get("question_number")
                        prompt = q_data.get("prompt_text")
                        a_start = q_data.get("audio_start_sec")
                        a_end = q_data.get("audio_end_sec")
                        page_ref = q_data.get("page_reference")

                        # Natural key for questions: (group_id, question_number)
                        stmt = select(Question).where(
                            Question.group_id == group.id,
                            Question.question_number == q_num,
                        )
                        question = self.db.execute(stmt).scalar_one_or_none()

                        if question is None:
                            question = Question(
                                group_id=group.id,
                                question_number=q_num,
                                prompt_text=prompt,
                                audio_start_sec=a_start,
                                audio_end_sec=a_end,
                                page_reference=page_ref,
                            )
                            self.db.add(question)
                            self.db.flush()
                            self.stats["questions_inserted"] += 1
                        else:
                            updated = False
                            if question.prompt_text != prompt:
                                question.prompt_text = prompt
                                updated = True
                            if question.audio_start_sec != a_start:
                                question.audio_start_sec = a_start
                                updated = True
                            if question.audio_end_sec != a_end:
                                question.audio_end_sec = a_end
                                updated = True
                            if question.page_reference != page_ref:
                                question.page_reference = page_ref
                                updated = True
                            if updated:
                                self.stats["questions_updated"] += 1
                            self.db.flush()

                        # 8. Options
                        for opt_data in q_data.get("options", []):
                            label = opt_data.get("option_label")
                            text = opt_data.get("option_text")

                            stmt = select(QuestionOption).where(
                                QuestionOption.question_id == question.id,
                                QuestionOption.option_label == label,
                            )
                            opt = self.db.execute(stmt).scalar_one_or_none()

                            if opt is None:
                                opt = QuestionOption(
                                    question_id=question.id,
                                    option_label=label,
                                    option_text=text,
                                )
                                self.db.add(opt)
                                self.db.flush()
                                self.stats["options_inserted"] += 1
                            else:
                                if opt.option_text != text:
                                    opt.option_text = text
                                    self.stats["options_updated"] += 1

                        # 9. Answer Key (1-1 with question)
                        ans_data = q_data.get("answer_key")
                        if ans_data and "correct_answer" in ans_data:
                            correct_ans = ans_data.get("correct_answer")
                            # Ensure list format for JSONB
                            if isinstance(correct_ans, str):
                                correct_ans = [correct_ans]
                            elif not isinstance(correct_ans, list):
                                correct_ans = [str(correct_ans)]

                            explanation = ans_data.get("explanation")

                            stmt = select(AnswerKey).where(
                                AnswerKey.question_id == question.id
                            )
                            ans_key = self.db.execute(stmt).scalar_one_or_none()

                            if ans_key is None:
                                ans_key = AnswerKey(
                                    question_id=question.id,
                                    correct_answer=correct_ans,
                                    explanation=explanation,
                                )
                                self.db.add(ans_key)
                                self.db.flush()
                                self.stats["answers_inserted"] += 1
                            else:
                                updated = False
                                if ans_key.correct_answer != correct_ans:
                                    ans_key.correct_answer = correct_ans
                                    updated = True
                                if ans_key.explanation != explanation:
                                    ans_key.explanation = explanation
                                    updated = True
                                if updated:
                                    self.stats["answers_updated"] += 1

        self.db.commit()


def seed_file(seed_path: Path, db) -> None:
    print(f"\n==================================================")
    print(f"[*] Seeding data from: {seed_path}")
    print(f"==================================================")
    with open(seed_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    book_dir = seed_path.parent.parent
    seeder = ContentSeeder(db)
    seeder.seed_book_data(data, book_dir)

    print("\n--- Summary of DB Operations ---")
    print(f"Books:        + {seeder.stats['books_inserted']} inserted, ~ {seeder.stats['books_updated']} updated")
    print(f"Tests:        + {seeder.stats['tests_inserted']} inserted, ~ {seeder.stats['tests_updated']} updated")
    print(f"Sections:     + {seeder.stats['sections_inserted']} inserted, ~ {seeder.stats['sections_updated']} updated")
    print(f"Audio Tracks: + {seeder.stats['audio_inserted']} inserted, ~ {seeder.stats['audio_updated']} updated")
    print(f"Passages:     + {seeder.stats['passages_inserted']} inserted, ~ {seeder.stats['passages_updated']} updated")
    print(f"Groups:       + {seeder.stats['groups_inserted']} inserted, ~ {seeder.stats['groups_updated']} updated")
    print(f"Questions:    + {seeder.stats['questions_inserted']} inserted, ~ {seeder.stats['questions_updated']} updated")
    print(f"Options:      + {seeder.stats['options_inserted']} inserted, ~ {seeder.stats['options_updated']} updated")
    print(f"Answer Keys:  + {seeder.stats['answers_inserted']} inserted, ~ {seeder.stats['answers_updated']} updated")
    print("--------------------------------------------------\n")


def main():
    parser = argparse.ArgumentParser(description="Seed or update IELTS book content into database (idempotent)")
    parser.add_argument("--book", type=str, help="Path to questions_seed.json or book directory")
    parser.add_argument("--all", action="store_true", help="Process all questions_seed.json files in content/")
    args = parser.parse_args()

    content_dir = Path(__file__).resolve().parent.parent.parent / "content"
    seed_files = []

    if args.book:
        p = Path(args.book)
        if not p.is_absolute():
            p = (Path.cwd() / p).resolve()
        if p.is_dir():
            target_json = p / "data" / "questions_seed.json"
            if target_json.exists():
                seed_files.append(target_json)
            else:
                print(f"[!] File not found: {target_json}")
        elif p.is_file():
            seed_files.append(p)
    elif args.all:
        if content_dir.exists():
            for child in sorted(content_dir.iterdir()):
                target_json = child / "data" / "questions_seed.json"
                if target_json.exists():
                    seed_files.append(target_json)
    else:
        parser.print_help()
        sys.exit(1)

    if not seed_files:
        print("[!] No questions_seed.json files found.")
        sys.exit(0)

    db = SessionLocal()
    try:
        for s_file in seed_files:
            seed_file(s_file, db)
    finally:
        db.close()


if __name__ == "__main__":
    main()
