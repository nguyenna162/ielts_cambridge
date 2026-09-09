import React, { useEffect, useState } from 'react';
import { Book, TestItem, Section } from '../types';
import { getBooks, getBookTests, getTestSections } from '../api';
import { Headphones, BookOpen, ChevronRight, Play } from 'lucide-react';

interface DashboardViewProps {
  selectedBookId: number | null;
  selectedTestId: number | null;
  onSelectBook: (bookId: number) => void;
  onSelectTest: (testId: number) => void;
  onStartExam: (sectionId: number) => void;
}

export const DashboardView: React.FC<DashboardViewProps> = ({
  selectedBookId,
  selectedTestId,
  onSelectBook,
  onSelectTest,
  onStartExam,
}) => {
  const [books, setBooks] = useState<Book[]>([]);
  const [selectedBook, setSelectedBook] = useState<Book | null>(null);
  const [tests, setTests] = useState<TestItem[]>([]);
  const [selectedTest, setSelectedTest] = useState<TestItem | null>(null);
  const [sections, setSections] = useState<Section[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    getBooks()
      .then(async (data) => {
        // Group and sort books logically: Cambridge IELTS (10 -> 15) then Destination (B1 -> B2 -> C1 & C2)
        const sorted = [...data].sort((a, b) => {
          const isDestA = a.title.toLowerCase().includes('destination');
          const isDestB = b.title.toLowerCase().includes('destination');
          if (isDestA !== isDestB) {
            return isDestA ? 1 : -1;
          }
          if (!isDestA) {
            const numA = parseInt(a.title.replace(/\D/g, ''), 10) || 0;
            const numB = parseInt(b.title.replace(/\D/g, ''), 10) || 0;
            return numA - numB;
          } else {
            const levelOrder: { [k: string]: number } = { b1: 1, b2: 2, c1: 3, c2: 4 };
            const getLevel = (t: string) => {
              const match = t.toLowerCase().match(/(b1|b2|c1|c2)/);
              return match ? levelOrder[match[1]] || 99 : 99;
            };
            return getLevel(a.title) - getLevel(b.title);
          }
        });
        setBooks(sorted);
        if (sorted.length > 0) {
          const targetBookId =
            selectedBookId ||
            (localStorage.getItem('ielts_selected_book_id')
              ? Number(localStorage.getItem('ielts_selected_book_id'))
              : null);
          const matchedBook = sorted.find((b) => b.id === targetBookId) || sorted[0];
          await handleSelectBook(matchedBook, selectedTestId);
        }
      })
      .finally(() => setLoading(false));
  }, []);

  const handleSelectBook = async (book: Book, initialTestId?: number | null) => {
    setSelectedBook(book);
    onSelectBook(book.id);
    localStorage.setItem('ielts_selected_book_id', String(book.id));
    setSelectedTest(null);
    setSections([]);
    try {
      const testList = await getBookTests(book.id);
      setTests(testList);
      if (testList.length > 0) {
        const targetTestId =
          initialTestId ||
          (localStorage.getItem('ielts_selected_test_id')
            ? Number(localStorage.getItem('ielts_selected_test_id'))
            : null);
        const matchedTest = testList.find((t) => t.id === targetTestId) || testList[0];
        await handleSelectTest(matchedTest);
      }
    } catch (e) {
      console.error(e);
    }
  };

  const handleSelectTest = async (test: TestItem) => {
    setSelectedTest(test);
    onSelectTest(test.id);
    localStorage.setItem('ielts_selected_test_id', String(test.id));
    try {
      const secList = await getTestSections(test.id);
      setSections(secList);
    } catch (e) {
      console.error(e);
    }
  };

  if (loading) {
    return (
      <div className="container" style={{ textAlign: 'center', padding: '4rem 0' }}>
        <p>Loading IELTS test library...</p>
      </div>
    );
  }

  return (
    <div className="container">
      <div className="hero-card">
        <h1 className="hero-title">Cambridge IELTS Practice Arena</h1>
        <p className="hero-subtitle">
          Realistic IELTS exam simulation with authentic Cambridge tests, real-time audio playback, automatic scoring, and detailed answer explanations.
        </p>
      </div>

      {/* Book Selection Tabs */}
      <div style={{ marginBottom: '1.5rem' }}>
        <h3 style={{ fontSize: '1.1rem', marginBottom: '0.75rem', fontWeight: 700 }}>Choose Book</h3>
        <div style={{ display: 'flex', gap: '0.75rem', flexWrap: 'wrap' }}>
          {books.map((b) => (
            <button
              key={b.id}
              onClick={() => handleSelectBook(b)}
              className={`btn ${selectedBook?.id === b.id ? 'btn-primary' : 'btn-outline'}`}
              style={{ padding: '0.6rem 1.2rem', borderRadius: '8px' }}
            >
              <BookOpen size={16} />
              <span>{b.title}</span>
            </button>
          ))}
        </div>
      </div>

      {/* Test / Unit Selection Tabs */}
      {selectedBook && (
        <div style={{ marginBottom: '1.5rem' }}>
          <h3 style={{ fontSize: '1.1rem', marginBottom: '0.75rem', fontWeight: 700 }}>
            {selectedBook.title.toLowerCase().includes('destination') ? 'Choose Unit' : 'Choose Test'}
          </h3>
          <div style={{ display: 'flex', gap: '0.6rem', flexWrap: 'wrap' }}>
            {tests.map((t) => (
              <button
                key={t.id}
                onClick={() => handleSelectTest(t)}
                className={`btn ${selectedTest?.id === t.id ? 'btn-primary' : 'btn-secondary'}`}
                style={{ padding: '0.5rem 1rem' }}
              >
                <span>
                  {selectedBook.title.toLowerCase().includes('destination')
                    ? `Unit ${t.test_number}`
                    : `Test ${t.test_number}`}
                </span>
              </button>
            ))}
          </div>
        </div>
      )}

      {/* Sections Cards */}
      {selectedTest && (
        <div>
          <h3 style={{ fontSize: '1.2rem', marginBottom: '1rem', fontWeight: 700 }}>
            {selectedBook?.title} —{' '}
            {selectedBook?.title.toLowerCase().includes('destination')
              ? `Unit ${selectedTest.test_number}`
              : `Test ${selectedTest.test_number} Sections`}
          </h3>

          <div className="card-grid">
            {sections.map((s) => {
              const isListening = s.skill === 'listening';
              const isDestination = selectedBook?.title.toLowerCase().includes('destination');
              return (
                <div key={s.id} className="card">
                  <div className="card-header">
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                      {isListening ? (
                        <Headphones size={20} color="#2563eb" />
                      ) : (
                        <BookOpen size={20} color="#0d9488" />
                      )}
                      <span className="card-title">
                        {isListening
                          ? `Listening Part ${s.part_number}`
                          : isDestination
                          ? `Grammar & Vocabulary Exercises`
                          : `Reading Passage ${s.part_number}`}
                      </span>
                    </div>
                    <span className="card-tag">
                      {isListening ? 'Audio Included' : isDestination ? 'Grammar & Vocab' : 'Reading'}
                    </span>
                  </div>

                  <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', marginBottom: '1.25rem', flex: 1 }}>
                    {isListening
                      ? 'Authentic British Council / Cambridge recording with note/table completion & multiple choice.'
                      : isDestination
                      ? 'Grammar practice, sentence correction, and vocabulary exercises with instant scoring.'
                      : 'Academic reading passage with multiple question types & instant computer scoring.'}
                  </p>

                  <button
                    className="btn btn-primary"
                    style={{ width: '100%' }}
                    onClick={() => onStartExam(s.id)}
                  >
                    <Play size={16} />
                    <span>Start Practice</span>
                  </button>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
};
