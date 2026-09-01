import React from 'react';
import { BookOpen, History, Settings, LogOut, User as UserIcon } from 'lucide-react';
import { User } from '../types';

interface NavbarProps {
  user: User | null;
  currentView: string;
  onNavigate: (view: string) => void;
  onLogout: () => void;
}

export const Navbar: React.FC<NavbarProps> = ({ user, currentView, onNavigate, onLogout }) => {
  return (
    <header className="app-header">
      <div className="brand" onClick={() => onNavigate('dashboard')}>
        <span>IELTS Practice Hub</span>
        <span className="brand-badge">Cambridge Edition</span>
      </div>

      <nav className="nav-links">
        <button
          className={`nav-btn ${currentView === 'dashboard' ? 'active' : ''}`}
          onClick={() => onNavigate('dashboard')}
        >
          <BookOpen size={16} />
          <span>Tests</span>
        </button>

        <button
          className={`nav-btn ${currentView === 'history' ? 'active' : ''}`}
          onClick={() => onNavigate('history')}
        >
          <History size={16} />
          <span>History</span>
        </button>

        {user?.is_admin && (
          <button
            className={`nav-btn ${currentView === 'admin' ? 'active' : ''}`}
            onClick={() => onNavigate('admin')}
          >
            <Settings size={16} />
            <span>Admin</span>
          </button>
        )}

        {user ? (
          <>
            <div className="user-badge">
              <UserIcon size={14} />
              <span>{user.username}</span>
            </div>
            <button className="nav-btn" onClick={onLogout} title="Logout">
              <LogOut size={16} />
            </button>
          </>
        ) : (
          <button className="btn btn-primary" onClick={() => onNavigate('login')}>
            Sign In
          </button>
        )}
      </nav>
    </header>
  );
};
