import React, { useEffect, useState } from 'react';
import { AttemptResult } from '../types';
import { getAttemptHistory } from '../api';
import { History, Eye, CheckCircle2, Award } from 'lucide-react';

interface HistoryViewProps {
  onViewResult: (result: AttemptResult) => void;
}

export const HistoryView: React.FC<HistoryViewProps> = ({ onViewResult }) => {
  const [history, setHistory] = useState<AttemptResult[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    getAttemptHistory()
      .then(setHistory)
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) {
    return (
      <div className="container" style={{ textAlign: 'center', padding: '4rem 0' }}>
        <p>Loading your test history...</p>
      </div>
    );
  }

  return (
    <div className="container" style={{ maxWidth: '1000px' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1.5rem' }}>
        <History size={24} color="#2563eb" />
        <h2 style={{ fontSize: '1.5rem', fontWeight: 800 }}>Practice History & Performance</h2>
      </div>

      {history.length === 0 ? (
        <div className="card" style={{ textAlign: 'center', padding: '3rem 1rem' }}>
          <p style={{ color: 'var(--text-muted)' }}>You haven't completed any practice sessions yet.</p>
        </div>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.85rem' }}>
          {history.map((att) => {
            const dateStr = new Date(att.started_at).toLocaleDateString('en-GB', {
              day: '2-digit',
              month: 'short',
              year: 'numeric',
              hour: '2-digit',
              minute: '2-digit',
            });

            return (
              <div
                key={att.id}
                className="card"
                style={{
                  flexDirection: 'row',
                  justifyContent: 'space-between',
                  alignItems: 'center',
                  padding: '1rem 1.25rem',
                }}
              >
                <div>
                  <div style={{ fontWeight: 700, fontSize: '1.05rem', color: 'var(--text-main)' }}>
                    {att.book_title || 'Cambridge IELTS'} — Test {att.test_number || 1}
                  </div>
                  <div style={{ color: 'var(--text-muted)', fontSize: '0.85rem', marginTop: '0.2rem' }}>
                    {att.skill?.toUpperCase()} Part {att.part_number} • {dateStr}
                  </div>
                </div>

                <div style={{ display: 'flex', alignItems: 'center', gap: '2rem' }}>
                  <div style={{ textAlign: 'right' }}>
                    <div style={{ fontSize: '1.25rem', fontWeight: 800, color: '#2563eb' }}>
                      {att.correct_count} / {att.total_questions}
                    </div>
                    <div style={{ fontSize: '0.8rem', color: '#16a34a', fontWeight: 600 }}>
                      {att.score_percentage}% Correct
                    </div>
                  </div>

                  <button
                    className="btn btn-outline"
                    style={{ padding: '0.5rem 0.9rem' }}
                    onClick={() => onViewResult(att)}
                  >
                    <Eye size={16} />
                    <span>Review</span>
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
};
