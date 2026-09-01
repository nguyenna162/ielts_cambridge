import React, { useState, useEffect } from 'react';
import { Clock } from 'lucide-react';

interface TimerProps {
  initialSeconds?: number;
  onTimeUp?: () => void;
}

export const Timer: React.FC<TimerProps> = ({ initialSeconds = 1800, onTimeUp }) => {
  const [secondsLeft, setSecondsLeft] = useState(initialSeconds);
  const [isRunning, setIsRunning] = useState(true);

  useEffect(() => {
    if (!isRunning) return;
    const interval = setInterval(() => {
      setSecondsLeft((prev) => {
        if (prev <= 1) {
          clearInterval(interval);
          if (onTimeUp) onTimeUp();
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    return () => clearInterval(interval);
  }, [isRunning, onTimeUp]);

  const m = Math.floor(secondsLeft / 60);
  const s = secondsLeft % 60;
  const timeFormatted = `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  const isUrgent = secondsLeft < 300;

  return (
    <div
      style={{
        display: 'flex',
        alignItems: 'center',
        gap: '0.4rem',
        padding: '0.4rem 0.8rem',
        borderRadius: '6px',
        backgroundColor: isUrgent ? '#fee2e2' : '#f1f5f9',
        color: isUrgent ? '#b91c1c' : '#1e293b',
        fontWeight: 700,
        fontSize: '0.95rem',
        border: `1px solid ${isUrgent ? '#fca5a5' : '#e2e8f0'}`,
      }}
    >
      <Clock size={16} color={isUrgent ? '#dc2626' : '#2563eb'} />
      <span>{timeFormatted}</span>
    </div>
  );
};
