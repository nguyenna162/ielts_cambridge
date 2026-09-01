import { Book, TestItem, Section, AttemptResult, User } from './types';

const API_BASE = '';

function getAuthHeaders(): HeadersInit {
  const token = localStorage.getItem('ielts_token');
  const headers: HeadersInit = {
    'Content-Type': 'application/json',
  };
  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }
  return headers;
}

export async function login(username: string, password: string): Promise<{ access_token: string; user: User }> {
  const res = await fetch(`${API_BASE}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password }),
  });
  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    throw new Error(err.detail || 'Login failed');
  }
  const data = await res.json();
  localStorage.setItem('ielts_token', data.access_token);
  return data;
}

export async function registerUser(username: string, password: string): Promise<{ access_token: string; user: User }> {
  const res = await fetch(`${API_BASE}/auth/register`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password }),
  });
  if (!res.ok) {
    const err = await res.json().catch(() => ({}));
    throw new Error(err.detail || 'Registration failed');
  }
  return res.json();
}

export async function getMe(): Promise<User> {
  const res = await fetch(`${API_BASE}/auth/me`, {
    headers: getAuthHeaders(),
  });
  if (!res.ok) {
    throw new Error('Failed to fetch user profile');
  }
  return res.json();
}

export async function getBooks(): Promise<Book[]> {
  const res = await fetch(`${API_BASE}/books`, {
    headers: getAuthHeaders(),
  });
  if (!res.ok) throw new Error('Failed to fetch books');
  return res.json();
}

export async function getBookTests(bookId: number): Promise<TestItem[]> {
  const res = await fetch(`${API_BASE}/books/${bookId}/tests`, {
    headers: getAuthHeaders(),
  });
  if (!res.ok) throw new Error('Failed to fetch tests');
  return res.json();
}

export async function getTestSections(testId: number): Promise<Section[]> {
  const res = await fetch(`${API_BASE}/tests/${testId}/sections`, {
    headers: getAuthHeaders(),
  });
  if (!res.ok) throw new Error('Failed to fetch sections');
  return res.json();
}

export async function getSectionDetail(sectionId: number): Promise<Section> {
  const res = await fetch(`${API_BASE}/sections/${sectionId}`, {
    headers: getAuthHeaders(),
  });
  if (!res.ok) throw new Error('Failed to fetch section details');
  return res.json();
}

export async function createAttempt(sectionId: number): Promise<{ id: number; section_id: number }> {
  const res = await fetch(`${API_BASE}/attempts`, {
    method: 'POST',
    headers: getAuthHeaders(),
    body: JSON.stringify({ section_id: sectionId }),
  });
  if (!res.ok) throw new Error('Failed to create attempt');
  return res.json();
}

export async function submitAttempt(
  attemptId: number,
  answers: { question_id: number; given_answer: string }[]
): Promise<AttemptResult> {
  const res = await fetch(`${API_BASE}/attempts/${attemptId}/submit`, {
    method: 'POST',
    headers: getAuthHeaders(),
    body: JSON.stringify({ answers }),
  });
  if (!res.ok) throw new Error('Failed to submit attempt');
  return res.json();
}

export async function getAttemptResult(attemptId: number): Promise<AttemptResult> {
  const res = await fetch(`${API_BASE}/attempts/${attemptId}/result`, {
    headers: getAuthHeaders(),
  });
  if (!res.ok) throw new Error('Failed to get attempt result');
  return res.json();
}

export async function getAttemptHistory(): Promise<AttemptResult[]> {
  const res = await fetch(`${API_BASE}/attempts/user/history`, {
    headers: getAuthHeaders(),
  });
  if (!res.ok) throw new Error('Failed to get attempt history');
  return res.json();
}

export function getAudioStreamUrl(sectionId: number): string {
  return `${API_BASE}/sections/${sectionId}/audio`;
}
