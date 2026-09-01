from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.orm import Session, selectinload

from app.db import get_db
from app.models import Book, Test
from app.schemas import BookOut, BookDetailOut, TestOut

router = APIRouter(prefix="/books", tags=["Books"])


@router.get("", response_model=List[BookOut])
def get_books(db: Session = Depends(get_db)):
    books = db.execute(select(Book).order_by(Book.id)).scalars().all()
    return [BookOut.model_validate(b) for b in books]


@router.get("/{id}", response_model=BookDetailOut)
def get_book(id: int, db: Session = Depends(get_db)):
    stmt = (
        select(Book)
        .where(Book.id == id)
        .options(
            selectinload(Book.tests).selectinload(Test.sections)
        )
    )
    book = db.execute(stmt).scalar_one_or_none()
    if not book:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Book not found",
        )
    return BookDetailOut.model_validate(book)


@router.get("/{id}/tests", response_model=List[TestOut])
def get_book_tests(id: int, db: Session = Depends(get_db)):
    tests = db.execute(
        select(Test).where(Test.book_id == id).order_by(Test.test_number)
    ).scalars().all()
    return [TestOut.model_validate(t) for t in tests]
