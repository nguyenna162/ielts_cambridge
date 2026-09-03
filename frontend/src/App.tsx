import React, { useState, useEffect } from 'react';
import { User, AttemptResult } from './types';
import { getMe } from './api';
import { Navbar } from './components/Navbar';
import { DashboardView } from './views/DashboardView';
import { ExamView } from './views/ExamView';
import { ResultView } from './views/ResultView';
import { HistoryView } from './views/HistoryView';
import { AdminView } from './views/AdminView';
import { LoginView } from './views/LoginView';

export const App: React.FC = () => {
  const [user, setUser] = useState<User | null>(null);
  const [currentView, setCurrentView] = useState<string>('dashboard');
  const [activeSectionId, setActiveSectionId] = useState<number | null>(null);
  const [lastResult, setLastResult] = useState<AttemptResult | null>(null);
  const [selectedBookId, setSelectedBookId] = useState<number | null>(() => {
    const saved = localStorage.getItem('ielts_selected_book_id');
    return saved ? Number(saved) : null;
  });
  const [selectedTestId, setSelectedTestId] = useState<number | null>(() => {
    const saved = localStorage.getItem('ielts_selected_test_id');
    return saved ? Number(saved) : null;
  });

  useEffect(() => {
    getMe()
      .then(setUser)
      .catch(() => {
        // Fallback default student
        setUser({
          id: 1,
          username: 'student',
          is_admin: false,
          created_at: new Date().toISOString(),
        });
      });
  }, []);

  const handleStartExam = (sectionId: number) => {
    setActiveSectionId(sectionId);
    setCurrentView('exam');
  };

  const handleFinishExam = (result: AttemptResult) => {
    setLastResult(result);
    setCurrentView('result');
  };

  const handleLogout = () => {
    localStorage.removeItem('ielts_token');
    setUser(null);
    setCurrentView('login');
  };

  return (
    <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
      <Navbar
        user={user}
        currentView={currentView}
        onNavigate={(view) => setCurrentView(view)}
        onLogout={handleLogout}
      />

      <main style={{ flex: 1, paddingBottom: '3rem' }}>
        {currentView === 'login' && (
          <LoginView
            onLoginSuccess={(u) => {
              setUser(u);
              setCurrentView('dashboard');
            }}
          />
        )}

        {currentView === 'dashboard' && (
          <DashboardView
            selectedBookId={selectedBookId}
            selectedTestId={selectedTestId}
            onSelectBook={(bId) => setSelectedBookId(bId)}
            onSelectTest={(tId) => setSelectedTestId(tId)}
            onStartExam={handleStartExam}
          />
        )}

        {currentView === 'exam' && activeSectionId && (
          <ExamView
            sectionId={activeSectionId}
            onFinish={handleFinishExam}
            onBack={() => setCurrentView('dashboard')}
          />
        )}

        {currentView === 'result' && lastResult && (
          <ResultView
            result={lastResult}
            onRetake={() => {
              if (lastResult.section_id) {
                handleStartExam(lastResult.section_id);
              } else {
                setCurrentView('dashboard');
              }
            }}
            onBackToDashboard={() => setCurrentView('dashboard')}
          />
        )}

        {currentView === 'history' && (
          <HistoryView
            onViewResult={(res) => {
              setLastResult(res);
              setCurrentView('result');
            }}
          />
        )}

        {currentView === 'admin' && <AdminView />}
      </main>
    </div>
  );
};

export default App;
