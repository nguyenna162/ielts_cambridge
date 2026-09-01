from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.orm import Session, selectinload

from app.db import get_db
from app.models import Test, Section
from app.schemas import TestOut, TestDetailOut, SectionOut

router = APIRouter(prefix="/tests", tags=["Tests"])


@router.get("/{id}", response_model=TestDetailOut)
def get_test(id: int, db: Session = Depends(get_db)):
    stmt = (
        select(Test)
        .where(Test.id == id)
        .options(
            selectinload(Test.sections).selectinload(Section.audio_track)
        )
    )
    test = db.execute(stmt).scalar_one_or_none()
    if not test:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Test not found",
        )
    return TestDetailOut.model_validate(test)


@router.get("/{id}/sections", response_model=List[SectionOut])
def get_test_sections(id: int, db: Session = Depends(get_db)):
    stmt = (
        select(Section)
        .where(Section.test_id == id)
        .options(selectinload(Section.audio_track))
        .order_by(Section.skill, Section.part_number)
    )
    sections = db.execute(stmt).scalars().all()
    return [SectionOut.model_validate(s) for s in sections]
