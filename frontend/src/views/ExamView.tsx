import React, { useEffect, useState } from 'react';
import { Section, AttemptResult } from '../types';
import { getSectionDetail, createAttempt, submitAttempt, getAudioStreamUrl } from '../api';
import { AudioPlayer } from '../components/AudioPlayer';
import { Timer } from '../components/Timer';
import { CheckCircle2, ArrowLeft, Send } from 'lucide-react';

interface ExamViewProps {
  sectionId: number;
  onFinish: (result: AttemptResult) => void;
  onBack: () => void;
}

export const ExamView: React.FC<ExamViewProps> = ({ sectionId, onFinish, onBack }) => {
  const [section, setSection] = useState<Section | null>(null);
  const [attemptId, setAttemptId] = useState<number | null>(null);
  const [answers, setAnswers] = useState<{ [questionId: number]: string }>({});
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    async function init() {
      try {
        const sec = await getSectionDetail(sectionId);
        setSection(sec);
        const att = await createAttempt(sectionId);
        setAttemptId(att.id);
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    }
    init();
  }, [sectionId]);

  const handleAnswerChange = (questionId: number, val: string) => {
    setAnswers((prev) => ({ ...prev, [questionId]: val }));
  };

  const handleSubmit = async () => {
    if (!attemptId) return;
    setSubmitting(true);
    try {
      const payload = Object.entries(answers).map(([qId, val]) => ({
        question_id: parseInt(qId, 10),
        given_answer: val,
      }));
      const res = await submitAttempt(attemptId, payload);
      onFinish(res);
    } catch (e) {
      alert('Error submitting attempt: ' + e);
      setSubmitting(false);
    }
  };

  if (loading || !section) {
    return (
      <div className="container" style={{ textAlign: 'center', padding: '4rem 0' }}>
        <p>Loading exam room...</p>
      </div>
    );
  }

  const isReading = section.skill === 'reading';
  const hasPassage = section.passages && section.passages.length > 0;
  const allQuestions = section.question_groups?.flatMap((g) => g.questions) || [];

  return (
    <div className="container" style={{ maxWidth: isReading ? '1500px' : '1080px' }}>
      {/* Sticky top control bar */}
      <div className="sticky-controls">
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
          <button className="btn btn-outline" onClick={onBack} style={{ padding: '0.4rem 0.75rem' }}>
            <ArrowLeft size={16} />
            <span>Back</span>
          </button>
          <div>
            <h2 style={{ fontSize: '1.1rem', fontWeight: 800 }}>
              {section.skill.toUpperCase()} — Part {section.part_number}
            </h2>
          </div>
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
          <Timer initialSeconds={isReading ? 1200 : 900} onTimeUp={handleSubmit} />
          <button
            className="btn btn-success"
            onClick={handleSubmit}
            disabled={submitting}
          >
            <Send size={16} />
            <span>{submitting ? 'Submitting...' : 'Submit Answers'}</span>
          </button>
        </div>
      </div>

      {/* Listening Audio Track */}
      {section.skill === 'listening' && (
        <AudioPlayer src={getAudioStreamUrl(section.id)} autoPlay={false} />
      )}

      {/* Main Testing Area */}
      <div className={`exam-layout ${isReading && hasPassage ? 'split-view' : ''}`}>
        {/* Reading Passage Panel */}
        {isReading && hasPassage && (
          <div className="passage-panel">
            {section.passages!.map((p) => (
              <div key={p.id} className="passage-content">
                {p.title && <h2 className="passage-title">{p.title}</h2>}
                <div className="passage-body">
                  {(p.body_text || '').split(/\n\n+/).map((paragraph, idx) => {
                    const trimmed = paragraph.trim();
                    if (!trimmed) return null;

                    // Check if it's a section header like **Section A** or **Paragraph A** or **A**
                    const sectionMatch = trimmed.match(/^\*\*(?:Section|Paragraph)?\s*([A-H])\*\*$/i);
                    if (sectionMatch) {
                      return (
                        <div key={idx} className="passage-section-badge">
                          Paragraph {sectionMatch[1].toUpperCase()}
                        </div>
                      );
                    }

                    return (
                      <p key={idx} className="passage-paragraph">
                        {trimmed}
                      </p>
                    );
                  })}
                </div>
              </div>
            ))}
          </div>
        )}

        {/* Questions Panel */}
        <div className="questions-panel">
          {section.question_groups?.map((group) => (
            <div key={group.id} className="q-group-box">
              {group.instruction && (
                <div className="q-group-instruction">
                  {group.instruction}
                </div>
              )}

              {group.questions.map((q) => {
                const currentVal = answers[q.id] || '';
                const hasOptions = q.options && q.options.length > 0;

                return (
                  <div key={q.id} id={`q-${q.question_number}`} className="q-item">
                    <div className="q-header">
                      <div className="q-number">{q.question_number}</div>
                      <div className="q-prompt">{q.prompt_text || `Question ${q.question_number}`}</div>
                    </div>

                    {hasOptions ? (
                      <div className="options-list">
                        {q.options.map((opt) => {
                          const isSelected = currentVal === (opt.option_label || opt.option_text);
                          return (
                            <label
                              key={opt.id}
                              className={`option-item ${isSelected ? 'selected' : ''}`}
                              onClick={() => handleAnswerChange(q.id, opt.option_label || opt.option_text || '')}
                            >
                              <input
                                type="radio"
                                name={`q-${q.id}`}
                                value={opt.option_label || opt.option_text}
                                checked={isSelected}
                                onChange={() => {}}
                                style={{ accentColor: '#2563eb' }}
                              />
                              <span style={{ fontWeight: 600 }}>{opt.option_label ? `${opt.option_label}.` : ''}</span>
                              <span>{opt.option_text}</span>
                            </label>
                          );
                        })}
                      </div>
                    ) : (
                      <div style={{ marginTop: '0.5rem' }}>
                        <input
                          type="text"
                          className="q-input-text"
                          placeholder="Type your answer here..."
                          value={currentVal}
                          onChange={(e) => handleAnswerChange(q.id, e.target.value)}
                        />
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
          ))}

          {/* Question Navigator */}
          <div style={{ marginTop: '2rem' }}>
            <h4 style={{ fontSize: '0.9rem', color: 'var(--text-muted)', marginBottom: '0.5rem' }}>
              Questions Navigator ({Object.keys(answers).length}/{allQuestions.length} answered)
            </h4>
            <div className="q-navigator">
              {allQuestions.map((q) => {
                const isAnswered = !!answers[q.id];
                return (
                  <button
                    key={q.id}
                    className={`q-nav-chip ${isAnswered ? 'answered' : ''}`}
                    onClick={() => {
                      const el = document.getElementById(`q-${q.question_number}`);
                      if (el) el.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    }}
                  >
                    {q.question_number}
                  </button>
                );
              })}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
