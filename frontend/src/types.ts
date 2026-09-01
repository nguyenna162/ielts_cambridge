export interface User {
  id: number;
  username: string;
  is_admin: boolean;
  created_at: string;
}

export interface Option {
  id: number;
  option_label?: string;
  option_text?: string;
}

export interface AnswerKey {
  id: number;
  correct_answer: string[] | string;
  explanation?: string;
}

export interface Question {
  id: number;
  question_number: number;
  prompt_text?: string;
  audio_start_sec?: number;
  audio_end_sec?: number;
  page_reference?: number;
  options: Option[];
  answer_key?: AnswerKey;
}

export interface QuestionGroup {
  id: number;
  group_order: number;
  question_type: string;
  instruction?: string;
  question_from: number;
  question_to: number;
  questions: Question[];
}

export interface Passage {
  id: number;
  title?: string;
  body_text?: string;
}

export interface AudioTrack {
  id: number;
  file_path: string;
  checksum: string;
  duration_seconds?: number;
}

export interface Section {
  id: number;
  test_id: number;
  skill: 'listening' | 'reading' | 'writing' | 'speaking';
  part_number: number;
  page_start?: number;
  page_end?: number;
  audio_track?: AudioTrack;
  passages?: Passage[];
  question_groups?: QuestionGroup[];
}

export interface TestItem {
  id: number;
  book_id: number;
  test_number: number;
  sections?: Section[];
}

export interface Book {
  id: number;
  title: string;
  total_pages?: number;
  source_pdf_path: string;
  source_pdf_checksum: string;
  created_at: string;
  tests?: TestItem[];
}

export interface UserAnswerItem {
  id: number;
  question_id?: number;
  question_number?: number;
  given_answer?: string;
  is_correct?: boolean;
  correct_answer?: string[] | string;
  explanation?: string;
}

export interface AttemptResult {
  id: number;
  user_id: number;
  section_id?: number;
  skill?: string;
  part_number?: number;
  test_number?: number;
  book_title?: string;
  started_at: string;
  finished_at?: string;
  total_questions: number;
  correct_count: number;
  score_percentage: number;
  answers: UserAnswerItem[];
}
