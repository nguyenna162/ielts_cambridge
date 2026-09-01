from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.orm import Session, selectinload

from app.db import get_db
from app.models import Section, QuestionGroup, Question
from app.schemas import SectionDetailOut

router = APIRouter(prefix="/sections", tags=["Sections"])


@router.get("/{id}", response_model=SectionDetailOut)
def get_section(id: int, db: Session = Depends(get_db)):
    stmt = (
        select(Section)
        .where(Section.id == id)
        .options(
            selectinload(Section.audio_track),
            selectinload(Section.passages),
            selectinload(Section.question_groups)
            .selectinload(QuestionGroup.questions)
            .selectinload(Question.options),
            selectinload(Section.question_groups)
            .selectinload(QuestionGroup.questions)
            .selectinload(Question.answer_key),
        )
    )
    section = db.execute(stmt).scalar_one_or_none()
    if not section:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Section not found",
        )
    return SectionDetailOut.model_validate(section)
