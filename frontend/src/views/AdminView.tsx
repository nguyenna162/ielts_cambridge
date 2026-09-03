import React, { useEffect, useState } from 'react';
import { Book, User } from '../types';
import { getBooks, getUsers, updateUserRole } from '../api';
import {
  Settings,
  Plus,
  Edit2,
  Trash2,
  Check,
  Users,
  BookOpen,
  Shield,
  ShieldCheck,
  ShieldAlert,
  CheckCircle2,
  AlertCircle,
  Crown,
} from 'lucide-react';

interface AdminViewProps {
  user?: User | null;
}

export const AdminView: React.FC<AdminViewProps> = ({ user }) => {
  const [activeTab, setActiveTab] = useState<'content' | 'users'>('content');

  // Content state
  const [books, setBooks] = useState<Book[]>([]);
  const [newTitle, setNewTitle] = useState('');
  const [newPages, setNewPages] = useState(147);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editTitle, setEditTitle] = useState('');

  // User management state
  const [userList, setUserList] = useState<User[]>([]);
  const [usersLoading, setUsersLoading] = useState(false);
  const [userSuccess, setUserSuccess] = useState('');
  const [userError, setUserError] = useState('');

  const isMasterAdmin = user?.username === 'na';

  useEffect(() => {
    loadBooks();
    loadUserList();
  }, []);

  const loadBooks = () => {
    getBooks().then(setBooks).catch(console.error);
  };

  const loadUserList = () => {
    setUsersLoading(true);
    getUsers()
      .then((data) => {
        setUserList(data);
        setUserError('');
      })
      .catch((err) => {
        setUserError(err.message || 'Không thể tải danh sách tài khoản');
      })
      .finally(() => setUsersLoading(false));
  };

  const handleCreateBook = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newTitle.trim()) return;
    try {
      const token = localStorage.getItem('ielts_token');
      const res = await fetch('/admin/books', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({
          title: newTitle,
          total_pages: newPages,
          source_pdf_path: `cambridge-ielts-${newTitle.toLowerCase().replace(/\s+/g, '-')}/source/book.pdf`,
          source_pdf_checksum: 'pending_checksum',
        }),
      });
      if (res.ok) {
        setNewTitle('');
        loadBooks();
      }
    } catch (err) {
      alert('Error: ' + err);
    }
  };

  const handleUpdateBook = async (id: number) => {
    try {
      const token = localStorage.getItem('ielts_token');
      const res = await fetch(`/admin/books/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ title: editTitle }),
      });
      if (res.ok) {
        setEditingId(null);
        loadBooks();
      }
    } catch (err) {
      alert('Error: ' + err);
    }
  };

  const handleDeleteBook = async (id: number) => {
    if (!window.confirm('Are you sure you want to delete this book?')) return;
    try {
      const token = localStorage.getItem('ielts_token');
      const res = await fetch(`/admin/books/${id}`, {
        method: 'DELETE',
        headers: { Authorization: `Bearer ${token}` },
      });
      if (res.ok) loadBooks();
    } catch (err) {
      alert('Error: ' + err);
    }
  };

  const handleToggleAdminRole = async (targetUser: User, makeAdmin: boolean) => {
    const actionDesc = makeAdmin
      ? `cấp quyền Quản trị (Admin) cho tài khoản "${targetUser.username}"`
      : `hạ quyền Admin của tài khoản "${targetUser.username}" xuống Student`;

    if (!window.confirm(`Xác nhận: Bạn có chắc chắn muốn ${actionDesc}?`)) {
      return;
    }

    setUserError('');
    setUserSuccess('');
    try {
      await updateUserRole(targetUser.id, makeAdmin);
      setUserSuccess(`Đã ${actionDesc} thành công!`);
      loadUserList();
    } catch (err: any) {
      setUserError(err.message || 'Lỗi khi cập nhật quyền tài khoản');
    }
  };

  return (
    <div className="container" style={{ maxWidth: '1000px' }}>
      {/* Header */}
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '1.5rem' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
          <Settings size={26} color="#2563eb" />
          <h2 style={{ fontSize: '1.5rem', fontWeight: 800 }}>Admin Dashboard</h2>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.85rem' }}>
          {isMasterAdmin ? (
            <span
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '0.35rem',
                background: '#fdf2f8',
                color: '#be185d',
                border: '1px solid #fbcfe8',
                padding: '0.25rem 0.65rem',
                borderRadius: '999px',
                fontWeight: 600,
              }}
            >
              <Crown size={14} />
              Master Admin (na)
            </span>
          ) : (
            <span
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '0.35rem',
                background: '#eff6ff',
                color: '#1d4ed8',
                border: '1px solid #bfdbfe',
                padding: '0.25rem 0.65rem',
                borderRadius: '999px',
                fontWeight: 600,
              }}
            >
              <Shield size={14} />
              Admin ({user?.username})
            </span>
          )}
        </div>
      </div>

      {/* Tabs */}
      <div style={{ display: 'flex', gap: '0.5rem', marginBottom: '1.5rem', borderBottom: '1px solid var(--border)', paddingBottom: '0.5rem' }}>
        <button
          className={`btn ${activeTab === 'content' ? 'btn-primary' : 'btn-outline'}`}
          style={{ display: 'inline-flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.9rem' }}
          onClick={() => setActiveTab('content')}
        >
          <BookOpen size={16} />
          <span>Quản lý Sách & Đề thi</span>
        </button>
        <button
          className={`btn ${activeTab === 'users' ? 'btn-primary' : 'btn-outline'}`}
          style={{ display: 'inline-flex', alignItems: 'center', gap: '0.5rem', fontSize: '0.9rem' }}
          onClick={() => {
            setActiveTab('users');
            loadUserList();
          }}
        >
          <Users size={16} />
          <span>Quản lý Tài khoản & Phân quyền Admin</span>
        </button>
      </div>

      {/* TAB 1: CONTENT */}
      {activeTab === 'content' && (
        <>
          {/* Add new book form */}
          <div className="card" style={{ marginBottom: '2rem' }}>
            <h3 style={{ fontSize: '1.1rem', fontWeight: 700, marginBottom: '1rem' }}>Add New Book Record</h3>
            <form onSubmit={handleCreateBook} style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap' }}>
              <input
                type="text"
                className="q-input-text"
                placeholder="Book Title (e.g. Cambridge IELTS 16)"
                value={newTitle}
                onChange={(e) => setNewTitle(e.target.value)}
                style={{ flex: 1 }}
                required
              />
              <input
                type="number"
                className="q-input-text"
                placeholder="Pages"
                value={newPages}
                onChange={(e) => setNewPages(parseInt(e.target.value, 10))}
                style={{ width: '120px' }}
              />
              <button type="submit" className="btn btn-primary">
                <Plus size={16} />
                <span>Create Book</span>
              </button>
            </form>
          </div>

          {/* Existing Books Table */}
          <div className="card">
            <h3 style={{ fontSize: '1.1rem', fontWeight: 700, marginBottom: '1rem' }}>Library Inventory</h3>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
              <thead>
                <tr style={{ borderBottom: '2px solid var(--border)', color: 'var(--text-muted)', fontSize: '0.85rem' }}>
                  <th style={{ padding: '0.75rem' }}>ID</th>
                  <th style={{ padding: '0.75rem' }}>Title</th>
                  <th style={{ padding: '0.75rem' }}>Pages</th>
                  <th style={{ padding: '0.75rem' }}>Source PDF</th>
                  <th style={{ padding: '0.75rem', textAlign: 'right' }}>Actions</th>
                </tr>
              </thead>
              <tbody>
                {books.map((b) => (
                  <tr key={b.id} style={{ borderBottom: '1px solid var(--border)' }}>
                    <td style={{ padding: '0.75rem', fontWeight: 600 }}>{b.id}</td>
                    <td style={{ padding: '0.75rem' }}>
                      {editingId === b.id ? (
                        <input
                          type="text"
                          value={editTitle}
                          onChange={(e) => setEditTitle(e.target.value)}
                          className="q-input-text"
                          style={{ padding: '0.2rem 0.5rem' }}
                        />
                      ) : (
                        <span style={{ fontWeight: 600 }}>{b.title}</span>
                      )}
                    </td>
                    <td style={{ padding: '0.75rem', color: 'var(--text-muted)' }}>{b.total_pages || 'N/A'}</td>
                    <td style={{ padding: '0.75rem', fontSize: '0.85rem', color: 'var(--text-muted)', fontFamily: 'monospace' }}>
                      {b.source_pdf_path}
                    </td>
                    <td style={{ padding: '0.75rem', textAlign: 'right' }}>
                      {editingId === b.id ? (
                        <button
                          className="btn btn-success"
                          style={{ padding: '0.3rem 0.6rem', fontSize: '0.8rem' }}
                          onClick={() => handleUpdateBook(b.id)}
                        >
                          <Check size={14} />
                        </button>
                      ) : (
                        <div style={{ display: 'inline-flex', gap: '0.5rem' }}>
                          <button
                            className="btn btn-outline"
                            style={{ padding: '0.3rem 0.6rem', fontSize: '0.8rem' }}
                            onClick={() => {
                              setEditingId(b.id);
                              setEditTitle(b.title);
                            }}
                          >
                            <Edit2 size={14} />
                          </button>
                          <button
                            className="btn btn-outline"
                            style={{ padding: '0.3rem 0.6rem', fontSize: '0.8rem', color: '#dc2626' }}
                            onClick={() => handleDeleteBook(b.id)}
                          >
                            <Trash2 size={14} />
                          </button>
                        </div>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </>
      )}

      {/* TAB 2: USERS & PERMISSIONS */}
      {activeTab === 'users' && (
        <div className="card">
          <div style={{ marginBottom: '1.25rem' }}>
            <h3 style={{ fontSize: '1.15rem', fontWeight: 700, marginBottom: '0.35rem' }}>
              Danh sách Tài khoản & Phân quyền Quản trị
            </h3>
            {isMasterAdmin ? (
              <p style={{ fontSize: '0.85rem', color: '#15803d' }}>
                ✓ Bạn đang đăng nhập với tư cách <strong>Master Admin (na)</strong>. Bạn có thẩm quyền duy nhất để duyệt/cấp quyền Admin cho các tài khoản học viên khác.
              </p>
            ) : (
              <p style={{ fontSize: '0.85rem', color: '#b45309' }}>
                ℹ Chỉ tài khoản <strong>na</strong> mới có thẩm quyền duyệt và cấp quyền Admin. Bạn đang xem ở chế độ chỉ đọc.
              </p>
            )}
          </div>

          {userSuccess && (
            <div
              style={{
                background: '#dcfce7',
                color: '#15803d',
                border: '1px solid #bbf7d0',
                padding: '0.65rem 0.85rem',
                borderRadius: '6px',
                fontSize: '0.85rem',
                marginBottom: '1rem',
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem',
              }}
            >
              <CheckCircle2 size={16} />
              <span>{userSuccess}</span>
            </div>
          )}

          {userError && (
            <div
              style={{
                background: '#fee2e2',
                color: '#b91c1c',
                border: '1px solid #fecaca',
                padding: '0.65rem 0.85rem',
                borderRadius: '6px',
                fontSize: '0.85rem',
                marginBottom: '1rem',
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem',
              }}
            >
              <AlertCircle size={16} />
              <span>{userError}</span>
            </div>
          )}

          {usersLoading ? (
            <div style={{ padding: '2rem', textAlign: 'center', color: 'var(--text-muted)' }}>
              Đang tải danh sách tài khoản...
            </div>
          ) : (
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
              <thead>
                <tr style={{ borderBottom: '2px solid var(--border)', color: 'var(--text-muted)', fontSize: '0.85rem' }}>
                  <th style={{ padding: '0.75rem' }}>ID</th>
                  <th style={{ padding: '0.75rem' }}>Tên tài khoản</th>
                  <th style={{ padding: '0.75rem' }}>Vai trò</th>
                  <th style={{ padding: '0.75rem' }}>Ngày tạo</th>
                  <th style={{ padding: '0.75rem', textAlign: 'right' }}>Thao tác</th>
                </tr>
              </thead>
              <tbody>
                {userList.map((u) => {
                  const isUserNa = u.username === 'na';
                  return (
                    <tr key={u.id} style={{ borderBottom: '1px solid var(--border)' }}>
                      <td style={{ padding: '0.75rem', fontWeight: 600 }}>{u.id}</td>
                      <td style={{ padding: '0.75rem' }}>
                        <span style={{ fontWeight: 600, color: isUserNa ? '#9333ea' : 'inherit' }}>
                          {u.username}
                        </span>
                      </td>
                      <td style={{ padding: '0.75rem' }}>
                        {isUserNa ? (
                          <span
                            style={{
                              background: '#f3e8ff',
                              color: '#7e22ce',
                              border: '1px solid #e9d5ff',
                              padding: '0.2rem 0.55rem',
                              borderRadius: '4px',
                              fontSize: '0.75rem',
                              fontWeight: 700,
                              display: 'inline-flex',
                              alignItems: 'center',
                              gap: '0.3rem',
                            }}
                          >
                            <Crown size={12} />
                            Super Admin
                          </span>
                        ) : u.is_admin ? (
                          <span
                            style={{
                              background: '#dbeafe',
                              color: '#1e40af',
                              border: '1px solid #bfdbfe',
                              padding: '0.2rem 0.55rem',
                              borderRadius: '4px',
                              fontSize: '0.75rem',
                              fontWeight: 600,
                            }}
                          >
                            Admin
                          </span>
                        ) : (
                          <span
                            style={{
                              background: '#f1f5f9',
                              color: '#475569',
                              border: '1px solid #e2e8f0',
                              padding: '0.2rem 0.55rem',
                              borderRadius: '4px',
                              fontSize: '0.75rem',
                              fontWeight: 500,
                            }}
                          >
                            Student
                          </span>
                        )}
                      </td>
                      <td style={{ padding: '0.75rem', fontSize: '0.85rem', color: 'var(--text-muted)' }}>
                        {new Date(u.created_at).toLocaleString('vi-VN', {
                          year: 'numeric',
                          month: '2-digit',
                          day: '2-digit',
                          hour: '2-digit',
                          minute: '2-digit',
                        })}
                      </td>
                      <td style={{ padding: '0.75rem', textAlign: 'right' }}>
                        {isUserNa ? (
                          <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)', fontStyle: 'italic' }}>
                            Chủ sở hữu
                          </span>
                        ) : isMasterAdmin ? (
                          !u.is_admin ? (
                            <button
                              className="btn btn-primary"
                              style={{
                                padding: '0.3rem 0.65rem',
                                fontSize: '0.8rem',
                                display: 'inline-flex',
                                alignItems: 'center',
                                gap: '0.35rem',
                              }}
                              onClick={() => handleToggleAdminRole(u, true)}
                            >
                              <ShieldCheck size={14} />
                              <span>Cấp quyền Admin</span>
                            </button>
                          ) : (
                            <button
                              className="btn btn-outline"
                              style={{
                                padding: '0.3rem 0.65rem',
                                fontSize: '0.8rem',
                                color: '#dc2626',
                                borderColor: '#fca5a5',
                                display: 'inline-flex',
                                alignItems: 'center',
                                gap: '0.35rem',
                              }}
                              onClick={() => handleToggleAdminRole(u, false)}
                            >
                              <ShieldAlert size={14} />
                              <span>Hạ quyền Admin</span>
                            </button>
                          )
                        ) : (
                          <span style={{ fontSize: '0.8rem', color: '#94a3b8', fontStyle: 'italic' }}>
                            Chỉ đọc
                          </span>
                        )}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          )}
        </div>
      )}
    </div>
  );
};
