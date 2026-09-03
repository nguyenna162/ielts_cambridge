from typing import Any, List, Optional
from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.models import (
    User,
    Book,
    Test,
    Section,
    QuestionGroup,
    Question,
    QuestionOption,
    AnswerKey,
)
from app.schemas import BookCreate, BookUpdate, BookOut, TestCreate, TestOut, UserOut
from app.services.auth_service import get_current_user

router = APIRouter(prefix="/admin", tags=["Admin CRUD"])


# Book CRUD
@router.post("/books", response_model=BookOut)
def create_book(
    data: BookCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    book = Book(
        title=data.title,
        total_pages=data.total_pages,
        source_pdf_path=data.source_pdf_path,
        source_pdf_checksum=data.source_pdf_checksum,
    )
    db.add(book)
    db.commit()
    db.refresh(book)
    return BookOut.model_validate(book)


@router.put("/books/{id}", response_model=BookOut)
def update_book(
    id: int,
    data: BookUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    book = db.get(Book, id)
    if not book:
        raise HTTPException(status_code=404, detail="Book not found")
    if data.title is not None:
        book.title = data.title
    if data.total_pages is not None:
        book.total_pages = data.total_pages
    if data.source_pdf_path is not None:
        book.source_pdf_path = data.source_pdf_path
    if data.source_pdf_checksum is not None:
        book.source_pdf_checksum = data.source_pdf_checksum
    db.commit()
    db.refresh(book)
    return BookOut.model_validate(book)


@router.delete("/books/{id}")
def delete_book(
    id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    book = db.get(Book, id)
    if not book:
        raise HTTPException(status_code=404, detail="Book not found")
    db.delete(book)
    db.commit()
    return {"ok": True, "deleted_id": id}


# Test CRUD
@router.post("/tests", response_model=TestOut)
def create_test(
    data: TestCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    test = Test(book_id=data.book_id, test_number=data.test_number)
    db.add(test)
    db.commit()
    db.refresh(test)
    return TestOut.model_validate(test)


@router.delete("/tests/{id}")
def delete_test(
    id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    test = db.get(Test, id)
    if not test:
        raise HTTPException(status_code=404, detail="Test not found")
    db.delete(test)
    db.commit()
    return {"ok": True, "deleted_id": id}


# Question update schema
class QuestionUpdate(BaseModel):
    prompt_text: Optional[str] = None
    audio_start_sec: Optional[float] = None
    audio_end_sec: Optional[float] = None
    page_reference: Optional[int] = None
    correct_answer: Optional[Any] = None
    explanation: Optional[str] = None


@router.put("/questions/{id}")
def update_question(
    id: int,
    data: QuestionUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    q = db.get(Question, id)
    if not q:
        raise HTTPException(status_code=404, detail="Question not found")

    if data.prompt_text is not None:
        q.prompt_text = data.prompt_text
    if data.audio_start_sec is not None:
        q.audio_start_sec = data.audio_start_sec
    if data.audio_end_sec is not None:
        q.audio_end_sec = data.audio_end_sec
    if data.page_reference is not None:
        q.page_reference = data.page_reference

    if data.correct_answer is not None or data.explanation is not None:
        ans_key = db.execute(
            select(AnswerKey).where(AnswerKey.question_id == q.id)
        ).scalar_one_or_none()
        if not ans_key:
            ans_key = AnswerKey(
                question_id=q.id,
                correct_answer=data.correct_answer if isinstance(data.correct_answer, list) else [data.correct_answer],
                explanation=data.explanation,
            )
            db.add(ans_key)
        else:
            if data.correct_answer is not None:
                ans_key.correct_answer = (
                    data.correct_answer if isinstance(data.correct_answer, list) else [data.correct_answer]
                )
            if data.explanation is not None:
                ans_key.explanation = data.explanation

    db.commit()
    return {"ok": True, "question_id": q.id}


# User & Role Management
class UserRoleUpdate(BaseModel):
    is_admin: bool


@router.get("/users", response_model=List[UserOut])
def list_users(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    if not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Admin privileges required to view user accounts",
        )
    users = db.execute(select(User).order_by(User.id.asc())).scalars().all()
    return [UserOut.model_validate(u) for u in users]


@router.patch("/users/{user_id}/role", response_model=UserOut)
def update_user_role(
    user_id: int,
    data: UserRoleUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    # Only the master account 'na' is allowed to promote or demote admin privileges
    if current_user.username != "na":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Chỉ tài khoản 'na' mới có quyền duyệt và cấp quyền Admin cho các tài khoản khác.",
        )

    target_user = db.get(User, user_id)
    if not target_user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found",
        )

    if target_user.username == "na" and not data.is_admin:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Không thể thu hồi quyền Admin của tài khoản chủ sở hữu 'na'.",
        )

    target_user.is_admin = data.is_admin
    db.commit()
    db.refresh(target_user)
    return UserOut.model_validate(target_user)

