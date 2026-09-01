"""initial schema

Revision ID: 0001_initial_schema
Revises: 
Create Date: 2026-08-31 22:25:00.000000

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = '0001_initial_schema'
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # books
    op.create_table(
        'books',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('title', sa.Text(), nullable=False),
        sa.Column('total_pages', sa.Integer(), nullable=True),
        sa.Column('source_pdf_path', sa.Text(), nullable=False),
        sa.Column('source_pdf_checksum', sa.Text(), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.PrimaryKeyConstraint('id')
    )

    # tests
    op.create_table(
        'tests',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('book_id', sa.Integer(), nullable=False),
        sa.Column('test_number', sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(['book_id'], ['books.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('book_id', 'test_number', name='tests_book_id_test_number_key')
    )

    # sections
    op.create_table(
        'sections',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('test_id', sa.Integer(), nullable=False),
        sa.Column('skill', sa.Text(), nullable=False),
        sa.Column('part_number', sa.Integer(), nullable=False),
        sa.Column('page_start', sa.Integer(), nullable=True),
        sa.Column('page_end', sa.Integer(), nullable=True),
        sa.CheckConstraint("skill IN ('listening','reading','writing','speaking')", name='sections_skill_check'),
        sa.ForeignKeyConstraint(['test_id'], ['tests.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('test_id', 'skill', 'part_number', name='sections_test_id_skill_part_number_key')
    )

    # audio_tracks
    op.create_table(
        'audio_tracks',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('section_id', sa.Integer(), nullable=False),
        sa.Column('file_path', sa.Text(), nullable=False),
        sa.Column('checksum', sa.Text(), nullable=False),
        sa.Column('duration_seconds', sa.Numeric(), nullable=True),
        sa.ForeignKeyConstraint(['section_id'], ['sections.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('section_id', name='audio_tracks_section_id_key')
    )

    # passages
    op.create_table(
        'passages',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('section_id', sa.Integer(), nullable=False),
        sa.Column('title', sa.Text(), nullable=True),
        sa.Column('body_text', sa.Text(), nullable=True),
        sa.ForeignKeyConstraint(['section_id'], ['sections.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )

    # question_groups
    op.create_table(
        'question_groups',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('section_id', sa.Integer(), nullable=False),
        sa.Column('group_order', sa.Integer(), nullable=False),
        sa.Column('question_type', sa.Text(), nullable=False),
        sa.Column('instruction', sa.Text(), nullable=True),
        sa.Column('question_from', sa.Integer(), nullable=False),
        sa.Column('question_to', sa.Integer(), nullable=False),
        sa.ForeignKeyConstraint(['section_id'], ['sections.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )

    # questions
    op.create_table(
        'questions',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('group_id', sa.Integer(), nullable=False),
        sa.Column('question_number', sa.Integer(), nullable=False),
        sa.Column('prompt_text', sa.Text(), nullable=True),
        sa.Column('audio_start_sec', sa.Numeric(), nullable=True),
        sa.Column('audio_end_sec', sa.Numeric(), nullable=True),
        sa.Column('page_reference', sa.Integer(), nullable=True),
        sa.ForeignKeyConstraint(['group_id'], ['question_groups.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('group_id', 'question_number', name='questions_group_id_question_number_key')
    )

    # question_options
    op.create_table(
        'question_options',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('question_id', sa.Integer(), nullable=False),
        sa.Column('option_label', sa.Text(), nullable=True),
        sa.Column('option_text', sa.Text(), nullable=True),
        sa.ForeignKeyConstraint(['question_id'], ['questions.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )

    # answer_keys
    op.create_table(
        'answer_keys',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('question_id', sa.Integer(), nullable=False),
        sa.Column('correct_answer', postgresql.JSONB(astext_type=sa.Text()), nullable=False),
        sa.Column('explanation', sa.Text(), nullable=True),
        sa.ForeignKeyConstraint(['question_id'], ['questions.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('question_id', name='answer_keys_question_id_key')
    )

    # users
    op.create_table(
        'users',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('username', sa.Text(), nullable=False),
        sa.Column('password_hash', sa.Text(), nullable=False),
        sa.Column('is_admin', sa.Boolean(), server_default=sa.text('false'), nullable=False),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('username', name='users_username_key')
    )

    # user_attempts
    op.create_table(
        'user_attempts',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('user_id', sa.Integer(), nullable=False),
        sa.Column('section_id', sa.Integer(), nullable=True),
        sa.Column('started_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=False),
        sa.Column('finished_at', sa.DateTime(timezone=True), nullable=True),
        sa.ForeignKeyConstraint(['section_id'], ['sections.id']),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )

    # user_answers
    op.create_table(
        'user_answers',
        sa.Column('id', sa.Integer(), sa.Identity(always=True), nullable=False),
        sa.Column('attempt_id', sa.Integer(), nullable=False),
        sa.Column('question_id', sa.Integer(), nullable=True),
        sa.Column('given_answer', sa.Text(), nullable=True),
        sa.Column('is_correct', sa.Boolean(), nullable=True),
        sa.ForeignKeyConstraint(['attempt_id'], ['user_attempts.id'], ondelete='CASCADE'),
        sa.ForeignKeyConstraint(['question_id'], ['questions.id']),
        sa.PrimaryKeyConstraint('id')
    )


def downgrade() -> None:
    op.drop_table('user_answers')
    op.drop_table('user_attempts')
    op.drop_table('users')
    op.drop_table('answer_keys')
    op.drop_table('question_options')
    op.drop_table('questions')
    op.drop_table('question_groups')
    op.drop_table('passages')
    op.drop_table('audio_tracks')
    op.drop_table('sections')
    op.drop_table('tests')
    op.drop_table('books')
