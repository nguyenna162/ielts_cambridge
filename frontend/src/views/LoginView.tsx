import React, { useState } from 'react';
import { login, registerUser } from '../api';
import { User } from '../types';
import { Lock, User as UserIcon, LogIn, UserPlus, CheckCircle2 } from 'lucide-react';

interface LoginViewProps {
  onLoginSuccess: (user: User) => void;
}

export const LoginView: React.FC<LoginViewProps> = ({ onLoginSuccess }) => {
  const [isRegisterMode, setIsRegisterMode] = useState(false);
  const [username, setUsername] = useState('student');
  const [password, setPassword] = useState('123456');
  const [error, setError] = useState('');
  const [successMessage, setSuccessMessage] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setSuccessMessage('');
    setLoading(true);

    if (isRegisterMode) {
      // Register Mode
      try {
        await registerUser(username, password);
        setSuccessMessage(`Registration successful for "${username}"! Please sign in with your new password.`);
        setIsRegisterMode(false);
      } catch (err: any) {
        setError(err.message || 'Registration failed');
      } finally {
        setLoading(false);
      }
    } else {
      // Sign In Mode
      try {
        const data = await login(username, password);
        onLoginSuccess(data.user);
      } catch (err: any) {
        setError(err.message || 'Login failed');
      } finally {
        setLoading(false);
      }
    }
  };

  const handleQuickLogin = async (u: string, p: string) => {
    setUsername(u);
    setPassword(p);
    setError('');
    setSuccessMessage('');
    setLoading(true);
    try {
      const data = await login(u, p);
      onLoginSuccess(data.user);
    } catch (err: any) {
      setError(err.message || 'Login failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container" style={{ maxWidth: '440px', marginTop: '3.5rem' }}>
      <div className="card" style={{ padding: '2rem' }}>
        <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
          <div
            style={{
              width: '52px',
              height: '52px',
              borderRadius: '50%',
              background: isRegisterMode ? '#f0fdf4' : 'var(--primary-light)',
              color: isRegisterMode ? 'var(--success)' : 'var(--primary)',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              margin: '0 auto 0.75rem auto',
            }}
          >
            {isRegisterMode ? <UserPlus size={26} /> : <LogIn size={26} />}
          </div>
          <h2 style={{ fontSize: '1.5rem', fontWeight: 800 }}>
            {isRegisterMode ? 'Create New Account' : 'Sign In'}
          </h2>
          <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem' }}>
            Cambridge IELTS Practice Platform
          </p>
        </div>

        {/* Tab switch */}
        <div style={{ display: 'flex', background: '#f1f5f9', padding: '0.25rem', borderRadius: '8px', marginBottom: '1.25rem' }}>
          <button
            type="button"
            className="btn"
            style={{
              flex: 1,
              padding: '0.45rem',
              fontSize: '0.85rem',
              background: !isRegisterMode ? 'white' : 'transparent',
              color: !isRegisterMode ? 'var(--text-main)' : 'var(--text-muted)',
              boxShadow: !isRegisterMode ? 'var(--shadow-sm)' : 'none',
            }}
            onClick={() => {
              setIsRegisterMode(false);
              setError('');
              setSuccessMessage('');
            }}
          >
            Sign In
          </button>
          <button
            type="button"
            className="btn"
            style={{
              flex: 1,
              padding: '0.45rem',
              fontSize: '0.85rem',
              background: isRegisterMode ? 'white' : 'transparent',
              color: isRegisterMode ? 'var(--text-main)' : 'var(--text-muted)',
              boxShadow: isRegisterMode ? 'var(--shadow-sm)' : 'none',
            }}
            onClick={() => {
              setIsRegisterMode(true);
              setError('');
              setSuccessMessage('');
              setUsername('');
              setPassword('');
            }}
          >
            Register Account
          </button>
        </div>

        {successMessage && (
          <div
            style={{
              background: '#dcfce7',
              color: '#15803d',
              border: '1px solid #bbf7d0',
              padding: '0.75rem 0.85rem',
              borderRadius: '6px',
              fontSize: '0.88rem',
              marginBottom: '1rem',
              display: 'flex',
              alignItems: 'center',
              gap: '0.5rem',
            }}
          >
            <CheckCircle2 size={18} />
            <span>{successMessage}</span>
          </div>
        )}

        {error && (
          <div
            style={{
              background: '#fee2e2',
              color: '#b91c1c',
              border: '1px solid #fecaca',
              padding: '0.65rem 0.85rem',
              borderRadius: '6px',
              fontSize: '0.85rem',
              marginBottom: '1rem',
            }}
          >
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          <div>
            <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, marginBottom: '0.35rem' }}>
              Username
            </label>
            <div style={{ position: 'relative' }}>
              <input
                type="text"
                className="q-input-text"
                placeholder="Enter username"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                style={{ width: '100%', paddingLeft: '2.2rem' }}
                required
              />
              <UserIcon
                size={16}
                color="#94a3b8"
                style={{ position: 'absolute', left: '0.75rem', top: '50%', transform: 'translateY(-50%)' }}
              />
            </div>
          </div>

          <div>
            <label style={{ display: 'block', fontSize: '0.85rem', fontWeight: 600, marginBottom: '0.35rem' }}>
              Password
            </label>
            <div style={{ position: 'relative' }}>
              <input
                type="password"
                className="q-input-text"
                placeholder="Enter password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                style={{ width: '100%', paddingLeft: '2.2rem' }}
                required
              />
              <Lock
                size={16}
                color="#94a3b8"
                style={{ position: 'absolute', left: '0.75rem', top: '50%', transform: 'translateY(-50%)' }}
              />
            </div>
          </div>

          <button
            type="submit"
            className="btn btn-primary"
            style={{ width: '100%', marginTop: '0.5rem', padding: '0.75rem' }}
            disabled={loading}
          >
            {loading ? (
              <span>{isRegisterMode ? 'Registering...' : 'Signing in...'}</span>
            ) : (
              <span>{isRegisterMode ? 'Register New Account' : 'Sign In'}</span>
            )}
          </button>
        </form>

        {!isRegisterMode && (
          <div style={{ marginTop: '1.5rem', paddingTop: '1.25rem', borderTop: '1px solid var(--border)', textAlign: 'center' }}>
            <div style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.6rem' }}>
              Quick Offline Access (DEV / LAN)
            </div>
            <div style={{ display: 'flex', gap: '0.5rem', justifyContent: 'center' }}>
              <button
                type="button"
                className="btn btn-outline"
                style={{ fontSize: '0.8rem', padding: '0.4rem 0.8rem' }}
                onClick={() => handleQuickLogin('student', '123456')}
              >
                Student
              </button>
              <button
                type="button"
                className="btn btn-outline"
                style={{ fontSize: '0.8rem', padding: '0.4rem 0.8rem' }}
                onClick={() => handleQuickLogin('admin', '1')}
              >
                Admin
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};
