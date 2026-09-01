import React from 'react';
import { AttemptResult } from '../types';
import { CheckCircle, XCircle, ArrowLeft, RotateCcw, Award } from 'lucide-react';

interface ResultViewProps {
  result: AttemptResult;
  onRetake: () => void;
  onBackToDashboard: () => void;
}

function calculateBandScore(correct: number, total: number): string {
  if (total <= 0) return 'N/A';
  const ratio = correct / total;
  if (ratio >= 0.95) return '9.0';
  if (ratio >= 0.90) return '8.5';
  if (ratio >= 0.82) return '8.0';
  if (ratio >= 0.75) return '7.5';
  if (ratio >= 0.68) return '7.0';
  if (ratio >= 0.58) return '6.5';
  if (ratio >= 0.50) return '6.0';
  if (ratio >= 0.40) return '5.5';
  if (ratio >= 0.30) return '5.0';
  return '4.5';
}

export const ResultView: React.FC<ResultViewProps> = ({ result, onRetake, onBackToDashboard }) => {
  const band = calculateBandScore(result.correct_count, result.total_questions);

  return (
    <div className="container" style={{ maxWidth: '900px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
        <button className="btn btn-outline" onClick={onBackToDashboard}>
          <ArrowLeft size={16} />
          <span>Dashboard</span>
        </button>
        <button className="btn btn-primary" onClick={onRetake}>
          <RotateCcw size={16} />
          <span>Practice Again</span>
        </button>
      </div>

      {/* Score Summary Banner */}
      <div className="score-banner">
        <div>
          <div style={{ fontSize: '0.9rem', color: '#94a3b8', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
            Total Score
          </div>
          <div className="score-number">
            {result.correct_count} / {result.total_questions}
          </div>
          <div style={{ color: '#cbd5e1', fontSize: '0.95rem' }}>{result.score_percentage}% Correct</div>
        </div>

        <div style={{ borderLeft: '1px solid rgba(255,255,255,0.15)', paddingLeft: '2rem' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.4rem', justifyContent: 'center', color: '#fbbf24', fontSize: '0.9rem', textTransform: 'uppercase' }}>
            <Award size={18} />
            <span>Estimated Band</span>
          </div>
          <div className="band-score">{band}</div>
          <div style={{ color: '#94a3b8', fontSize: '0.85rem' }}>CEFR Level: {parseFloat(band) >= 7.5 ? 'C1/C2' : parseFloat(band) >= 6.0 ? 'B2' : 'B1'}</div>
        </div>
      </div>

      {/* Detailed Question Review */}
      <div style={{ background: 'white', border: '1px solid var(--border)', borderRadius: 'var(--radius-md)', padding: '1.5rem' }}>
        <h3 style={{ fontSize: '1.2rem', fontWeight: 800, marginBottom: '1.25rem', borderBottom: '2px solid var(--border)', paddingBottom: '0.5rem' }}>
          Answer Review & Key Explanations
        </h3>

        <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          {result.answers.map((a, idx) => {
            const isCorrect = a.is_correct;
            const correctAnsStr = Array.isArray(a.correct_answer)
              ? a.correct_answer.join(' / ')
              : a.correct_answer || 'N/A';

            return (
              <div
                key={a.id || idx}
                style={{
                  border: `1px solid ${isCorrect ? '#bbf7d0' : '#fecaca'}`,
                  backgroundColor: isCorrect ? '#f0fdf4' : '#fef2f2',
                  borderRadius: '8px',
                  padding: '1rem',
                }}
              >
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.4rem' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontWeight: 700 }}>
                    {isCorrect ? (
                      <CheckCircle size={18} color="#16a34a" />
                    ) : (
                      <XCircle size={18} color="#dc2626" />
                    )}
                    <span>Question {a.question_number || idx + 1}</span>
                  </div>
                  <span className={isCorrect ? 'badge-correct' : 'badge-incorrect'}>
                    {isCorrect ? 'CORRECT (+1)' : 'INCORRECT'}
                  </span>
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.5rem', fontSize: '0.92rem', marginTop: '0.5rem' }}>
                  <div>
                    <span style={{ color: 'var(--text-muted)' }}>Your Answer: </span>
                    <strong style={{ color: isCorrect ? '#15803d' : '#b91c1c' }}>
                      {a.given_answer ? `"${a.given_answer}"` : '(No answer provided)'}
                    </strong>
                  </div>
                  <div>
                    <span style={{ color: 'var(--text-muted)' }}>Correct Key: </span>
                    <strong style={{ color: '#1e40af' }}>"{correctAnsStr}"</strong>
                  </div>
                </div>

                {a.explanation && (
                  <div style={{ marginTop: '0.5rem', fontSize: '0.85rem', color: '#475569', fontStyle: 'italic', background: 'rgba(255,255,255,0.7)', padding: '0.4rem 0.6rem', borderRadius: '4px' }}>
                    💡 Explanation: {a.explanation}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};
