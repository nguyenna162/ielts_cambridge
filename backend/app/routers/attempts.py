from datetime import datetime, timezone
from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.orm import Session, selectinload

from app.db import get_db
from app.models import (
    User,
    UserAttempt,
    UserAnswer,
    Section,
    QuestionGroup,
    Question,
    AnswerKey,
)
from app.schemas import (
    AttemptCreate,
    AttemptSubmit,
    AttemptResultOut,
    UserAnswerOut,
)
from app.services.auth_service import get_current_user
from app.services.grading_service import check_answer

router = APIRouter(prefix="/attempts", tags=["Attempts"])


@router.post("", response_model=dict)
def create_attempt(
    data: AttemptCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    section = db.get(Section, data.section_id)
    if not section:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Section not found",
        )

    attempt = UserAttempt(
        user_id=current_user.id,
        section_id=section.id,
        started_at=datetime.now(timezone.utc),
    )
    db.add(attempt)
    db.commit()
    db.refresh(attempt)

    return {"id": attempt.id, "section_id": attempt.section_id, "started_at": attempt.started_at}


@router.post("/{id}/submit", response_model=AttemptResultOut)
def submit_attempt(
    id: int,
    data: AttemptSubmit,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    attempt = db.get(UserAttempt, id)
    if not attempt:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Attempt not found",
        )

    if attempt.user_id != current_user.id and not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not authorized to submit this attempt",
        )

    attempt.finished_at = datetime.now(timezone.utc)

    # Delete any previous answers for this attempt if resubmitting
    db.query(UserAnswer).filter(UserAnswer.attempt_id == attempt.id).delete()

    for item in data.answers:
        question = db.get(Question, item.question_id)
        if not question:
            continue

        ans_key = db.execute(
            select(AnswerKey).where(AnswerKey.question_id == question.id)
        ).scalar_one_or_none()

        is_correct = False
        if ans_key and ans_key.correct_answer:
            is_correct = check_answer(item.given_answer, ans_key.correct_answer)

        user_ans = UserAnswer(
            attempt_id=attempt.id,
            question_id=question.id,
            given_answer=item.given_answer,
            is_correct=is_correct,
        )
        db.add(user_ans)

    db.commit()
    return get_attempt_result(id, current_user, db)


@router.get("/{id}/result", response_model=AttemptResultOut)
def get_attempt_result(
    id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    stmt = (
        select(UserAttempt)
        .where(UserAttempt.id == id)
        .options(
            selectinload(UserAttempt.section)
            .selectinload(Section.test),
            selectinload(UserAttempt.answers)
            .selectinload(UserAnswer.question)
            .selectinload(Question.answer_key),
        )
    )
    attempt = db.execute(stmt).scalar_one_or_none()
    if not attempt:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Attempt not found",
        )

    # Calculate statistics
    total_q = len(attempt.answers)
    correct_count = sum(1 for a in attempt.answers if a.is_correct)
    score_pct = round((correct_count / total_q * 100) if total_q > 0 else 0.0, 2)

    sec = attempt.section
    test_num = sec.test.test_number if sec and sec.test else None
    book_title = sec.test.book.title if sec and sec.test and sec.test.book else None

    answers_out = []
    for a in sorted(attempt.answers, key=lambda x: x.question.question_number if x.question else x.id):
        q = a.question
        ans_key = q.answer_key if q else None
        answers_out.append(
            UserAnswerOut(
                id=a.id,
                question_id=a.question_id,
                question_number=q.question_number if q else None,
                given_answer=a.given_answer,
                is_correct=a.is_correct,
                correct_answer=ans_key.correct_answer if ans_key else None,
                explanation=ans_key.explanation if ans_key else None,
            )
        )

    return AttemptResultOut(
        id=attempt.id,
        user_id=attempt.user_id,
        section_id=attempt.section_id,
        skill=sec.skill if sec else None,
        part_number=sec.part_number if sec else None,
        test_number=test_num,
        book_title=book_title,
        started_at=attempt.started_at,
        finished_at=attempt.finished_at,
        total_questions=total_q,
        correct_count=correct_count,
        score_percentage=score_pct,
        answers=answers_out,
    )


@router.get("/user/history", response_model=List[AttemptResultOut])
def get_user_history(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    stmt = (
        select(UserAttempt)
        .where(UserAttempt.user_id == current_user.id)
        .order_by(UserAttempt.started_at.desc())
    )
    attempts = db.execute(stmt).scalars().all()
    results = []
    for att in attempts:
        try:
            results.append(get_attempt_result(att.id, current_user, db))
        except Exception:
            pass
    return results
