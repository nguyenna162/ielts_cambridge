import React, { useEffect, useState } from 'react';
import { Book } from '../types';
import { getBooks } from '../api';
import { Settings, Plus, Edit2, Trash2, Check } from 'lucide-react';

export const AdminView: React.FC = () => {
  const [books, setBooks] = useState<Book[]>([]);
  const [newTitle, setNewTitle] = useState('');
  const [newPages, setNewPages] = useState(147);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [editTitle, setEditTitle] = useState('');

  useEffect(() => {
    loadBooks();
  }, []);

  const loadBooks = () => {
    getBooks().then(setBooks).catch(console.error);
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

  return (
    <div className="container" style={{ maxWidth: '1000px' }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '1.5rem' }}>
        <Settings size={24} color="#2563eb" />
        <h2 style={{ fontSize: '1.5rem', fontWeight: 800 }}>Content Administration</h2>
      </div>

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
    </div>
  );
};
