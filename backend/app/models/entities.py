from datetime import datetime, timezone
from decimal import Decimal
from typing import Any, List, Optional
# pyrefly: ignore [missing-import]
from sqlalchemy import (
    CheckConstraint,
    Column,
    ForeignKey,
    Identity,
    Integer,
    Numeric,
    String,
    Text,
    Boolean,
    DateTime,
    UniqueConstraint,
)
from sqlalchemy.dialects.postgresql import JSONB
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func

from app.db import Base


class Book(Base):
    __tablename__ = "books"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    title: Mapped[str] = mapped_column(Text, nullable=False)
    total_pages: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    source_pdf_path: Mapped[str] = mapped_column(Text, nullable=False)
    source_pdf_checksum: Mapped[str] = mapped_column(Text, nullable=False)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), nullable=False
    )

    tests: Mapped[List["Test"]] = relationship(
        "Test", back_populates="book", cascade="all, delete-orphan"
    )


class Test(Base):
    __tablename__ = "tests"
    __table_args__ = (
        UniqueConstraint("book_id", "test_number", name="tests_book_id_test_number_key"),
    )

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    book_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("books.id", ondelete="CASCADE"), nullable=False
    )
    test_number: Mapped[int] = mapped_column(Integer, nullable=False)

    book: Mapped["Book"] = relationship("Book", back_populates="tests")
    sections: Mapped[List["Section"]] = relationship(
        "Section", back_populates="test", cascade="all, delete-orphan"
    )


class Section(Base):
    __tablename__ = "sections"
    __table_args__ = (
        CheckConstraint(
            "skill IN ('listening', 'reading', 'writing', 'speaking')",
            name="sections_skill_check",
        ),
        UniqueConstraint(
            "test_id", "skill", "part_number", name="sections_test_id_skill_part_number_key"
        ),
    )

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    test_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("tests.id", ondelete="CASCADE"), nullable=False
    )
    skill: Mapped[str] = mapped_column(Text, nullable=False)
    part_number: Mapped[int] = mapped_column(Integer, nullable=False)
    page_start: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)
    page_end: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)

    test: Mapped["Test"] = relationship("Test", back_populates="sections")
    audio_track: Mapped[Optional["AudioTrack"]] = relationship(
        "AudioTrack", back_populates="section", uselist=False, cascade="all, delete-orphan"
    )
    passages: Mapped[List["Passage"]] = relationship(
        "Passage", back_populates="section", cascade="all, delete-orphan"
    )
    question_groups: Mapped[List["QuestionGroup"]] = relationship(
        "QuestionGroup", back_populates="section", cascade="all, delete-orphan"
    )
    attempts: Mapped[List["UserAttempt"]] = relationship(
        "UserAttempt", back_populates="section"
    )


class AudioTrack(Base):
    __tablename__ = "audio_tracks"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    section_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("sections.id", ondelete="CASCADE"), unique=True, nullable=False
    )
    file_path: Mapped[str] = mapped_column(Text, nullable=False)
    checksum: Mapped[str] = mapped_column(Text, nullable=False)
    duration_seconds: Mapped[Optional[Decimal]] = mapped_column(Numeric, nullable=True)

    section: Mapped["Section"] = relationship("Section", back_populates="audio_track")


class Passage(Base):
    __tablename__ = "passages"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    section_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("sections.id", ondelete="CASCADE"), nullable=False
    )
    title: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    body_text: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    section: Mapped["Section"] = relationship("Section", back_populates="passages")


class QuestionGroup(Base):
    __tablename__ = "question_groups"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    section_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("sections.id", ondelete="CASCADE"), nullable=False
    )
    group_order: Mapped[int] = mapped_column(Integer, nullable=False)
    question_type: Mapped[str] = mapped_column(Text, nullable=False)
    instruction: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    question_from: Mapped[int] = mapped_column(Integer, nullable=False)
    question_to: Mapped[int] = mapped_column(Integer, nullable=False)

    section: Mapped["Section"] = relationship("Section", back_populates="question_groups")
    questions: Mapped[List["Question"]] = relationship(
        "Question", back_populates="group", cascade="all, delete-orphan"
    )


class Question(Base):
    __tablename__ = "questions"
    __table_args__ = (
        UniqueConstraint(
            "group_id", "question_number", name="questions_group_id_question_number_key"
        ),
    )

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    group_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("question_groups.id", ondelete="CASCADE"), nullable=False
    )
    question_number: Mapped[int] = mapped_column(Integer, nullable=False)
    prompt_text: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    audio_start_sec: Mapped[Optional[Decimal]] = mapped_column(Numeric, nullable=True)
    audio_end_sec: Mapped[Optional[Decimal]] = mapped_column(Numeric, nullable=True)
    page_reference: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)

    group: Mapped["QuestionGroup"] = relationship("QuestionGroup", back_populates="questions")
    options: Mapped[List["QuestionOption"]] = relationship(
        "QuestionOption", back_populates="question", cascade="all, delete-orphan"
    )
    answer_key: Mapped[Optional["AnswerKey"]] = relationship(
        "AnswerKey", back_populates="question", uselist=False, cascade="all, delete-orphan"
    )
    user_answers: Mapped[List["UserAnswer"]] = relationship(
        "UserAnswer", back_populates="question"
    )


class QuestionOption(Base):
    __tablename__ = "question_options"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    question_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("questions.id", ondelete="CASCADE"), nullable=False
    )
    option_label: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    option_text: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    question: Mapped["Question"] = relationship("Question", back_populates="options")


class AnswerKey(Base):
    __tablename__ = "answer_keys"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    question_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("questions.id", ondelete="CASCADE"), unique=True, nullable=False
    )
    correct_answer: Mapped[Any] = mapped_column(JSONB, nullable=False)
    explanation: Mapped[Optional[str]] = mapped_column(Text, nullable=True)

    question: Mapped["Question"] = relationship("Question", back_populates="answer_key")


class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    username: Mapped[str] = mapped_column(Text, unique=True, nullable=False)
    password_hash: Mapped[str] = mapped_column(Text, nullable=False)
    is_admin: Mapped[bool] = mapped_column(Boolean, default=False, nullable=False)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), nullable=False
    )

    attempts: Mapped[List["UserAttempt"]] = relationship(
        "UserAttempt", back_populates="user", cascade="all, delete-orphan"
    )


class UserAttempt(Base):
    __tablename__ = "user_attempts"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    user_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False
    )
    section_id: Mapped[Optional[int]] = mapped_column(
        Integer, ForeignKey("sections.id"), nullable=True
    )
    started_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), nullable=False
    )
    finished_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime(timezone=True), nullable=True
    )

    user: Mapped["User"] = relationship("User", back_populates="attempts")
    section: Mapped[Optional["Section"]] = relationship("Section", back_populates="attempts")
    answers: Mapped[List["UserAnswer"]] = relationship(
        "UserAnswer", back_populates="attempt", cascade="all, delete-orphan"
    )


class UserAnswer(Base):
    __tablename__ = "user_answers"

    id: Mapped[int] = mapped_column(
        Integer, Identity(always=True), primary_key=True
    )
    attempt_id: Mapped[int] = mapped_column(
        Integer, ForeignKey("user_attempts.id", ondelete="CASCADE"), nullable=False
    )
    question_id: Mapped[Optional[int]] = mapped_column(
        Integer, ForeignKey("questions.id"), nullable=True
    )
    given_answer: Mapped[Optional[str]] = mapped_column(Text, nullable=True)
    is_correct: Mapped[Optional[bool]] = mapped_column(Boolean, nullable=True)

    attempt: Mapped["UserAttempt"] = relationship("UserAttempt", back_populates="answers")
    question: Mapped[Optional["Question"]] = relationship("Question", back_populates="user_answers")
