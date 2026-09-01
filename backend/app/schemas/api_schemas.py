from datetime import datetime
from typing import Any, List, Optional
from pydantic import BaseModel, ConfigDict


# Auth Schemas
class UserRegister(BaseModel):
    username: str                                   
    password: str
    is_admin: bool = False


class UserLogin(BaseModel):
    username: str
    password: str


class UserOut(BaseModel):
    id: int
    username: str
    is_admin: bool
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)


class TokenOut(BaseModel):
    access_token: str
    token_type: str = "bearer"
    user: UserOut


# Book Schemas
class BookBase(BaseModel):
    title: str
    total_pages: Optional[int] = None
    source_pdf_path: str
    source_pdf_checksum: str


class BookCreate(BookBase):
    pass


class BookUpdate(BaseModel):
    title: Optional[str] = None
    total_pages: Optional[int] = None
    source_pdf_path: Optional[str] = None
    source_pdf_checksum: Optional[str] = None


class BookOut(BookBase):
    id: int
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)


# Test Schemas
class TestBase(BaseModel):
    test_number: int


class TestCreate(TestBase):
    book_id: int


class TestOut(TestBase):
    id: int
    book_id: int

    model_config = ConfigDict(from_attributes=True)


# Section Schemas
class AudioTrackOut(BaseModel):
    id: int
    file_path: str
    checksum: str
    duration_seconds: Optional[float] = None

    model_config = ConfigDict(from_attributes=True)


class PassageOut(BaseModel):
    id: int
    title: Optional[str] = None
    body_text: Optional[str] = None

    model_config = ConfigDict(from_attributes=True)


class OptionOut(BaseModel):
    id: int
    option_label: Optional[str] = None
    option_text: Optional[str] = None

    model_config = ConfigDict(from_attributes=True)


class AnswerKeyOut(BaseModel):
    id: int
    correct_answer: Any
    explanation: Optional[str] = None

    model_config = ConfigDict(from_attributes=True)


class QuestionOut(BaseModel):
    id: int
    question_number: int
    prompt_text: Optional[str] = None
    audio_start_sec: Optional[float] = None
    audio_end_sec: Optional[float] = None
    page_reference: Optional[int] = None
    options: List[OptionOut] = []
    answer_key: Optional[AnswerKeyOut] = None

    model_config = ConfigDict(from_attributes=True)


class QuestionGroupOut(BaseModel):
    id: int
    group_order: int
    question_type: str
    instruction: Optional[str] = None
    question_from: int
    question_to: int
    questions: List[QuestionOut] = []

    model_config = ConfigDict(from_attributes=True)


class SectionOut(BaseModel):
    id: int
    test_id: int
    skill: str
    part_number: int
    page_start: Optional[int] = None
    page_end: Optional[int] = None
    audio_track: Optional[AudioTrackOut] = None

    model_config = ConfigDict(from_attributes=True)


class SectionDetailOut(SectionOut):
    passages: List[PassageOut] = []
    question_groups: List[QuestionGroupOut] = []


class TestDetailOut(TestOut):
    sections: List[SectionOut] = []


class BookDetailOut(BookOut):
    tests: List[TestDetailOut] = []


# Attempt Schemas
class AttemptCreate(BaseModel):
    section_id: int


class GivenAnswerIn(BaseModel):
    question_id: int
    given_answer: str


class AttemptSubmit(BaseModel):
    answers: List[GivenAnswerIn]


class UserAnswerOut(BaseModel):
    id: int
    question_id: Optional[int]
    question_number: Optional[int] = None
    given_answer: Optional[str]
    is_correct: Optional[bool]
    correct_answer: Optional[Any] = None
    explanation: Optional[str] = None

    model_config = ConfigDict(from_attributes=True)


class AttemptResultOut(BaseModel):
    id: int
    user_id: int
    section_id: Optional[int]
    skill: Optional[str] = None
    part_number: Optional[int] = None
    test_number: Optional[int] = None
    book_title: Optional[str] = None
    started_at: datetime
    finished_at: Optional[datetime]
    total_questions: int
    correct_count: int
    score_percentage: float
    answers: List[UserAnswerOut] = []

    model_config = ConfigDict(from_attributes=True)
