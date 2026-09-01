import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    proxy: {
      '/auth': 'http://localhost:8000',
      '/books': 'http://localhost:8000',
      '/tests': 'http://localhost:8000',
      '/sections': 'http://localhost:8000',
      '/attempts': 'http://localhost:8000',
      '/admin': 'http://localhost:8000',
      '/healthz': 'http://localhost:8000'
    }
  },
  build: {
    outDir: 'dist',
    assetsDir: 'assets',
  }
})
