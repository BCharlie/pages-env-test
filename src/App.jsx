import { useState, useEffect } from 'react'
import './App.css'

function App() {
  const [buildTime, setBuildTime] = useState('')

  useEffect(() => {
    setBuildTime(new Date().toISOString())
  }, [])

  return (
    <div className="container">
      <h1>Cloudflare Pages Test</h1>
      <div className="branch">
        <h2>🚀 {import.meta.env.VITE_BRANCH || 'DEV'} ENVIRONMENT</h2>
        <p>React + Vite with environment variable injection</p>
      </div>
      
      <div className="env-info">
        <h3>Environment Variables</h3>
        <div className="env-item">
          <span className="env-label">Environment:</span>
          <span className="env-value">{import.meta.env.VITE_ENV_NAME || 'development'}</span>
        </div>
        <div className="env-item">
          <span className="env-label">API URL:</span>
          <span className="env-value">{import.meta.env.VITE_API_URL || 'https://api.dev.com'}</span>
        </div>
        <div className="env-item">
          <span className="env-label">Feature Flag:</span>
          <span className="env-value">{import.meta.env.VITE_FEATURE_FLAG || 'false'}</span>
        </div>
        <div className="env-item">
          <span className="env-label">Branch:</span>
          <span className="env-value">{import.meta.env.VITE_BRANCH || 'dev'}</span>
        </div>
        <div className="env-item">
          <span className="env-label">Mode:</span>
          <span className="env-value">{import.meta.env.MODE}</span>
        </div>
      </div>
      
      <p>✅ Built with React + Vite</p>
      <p>⏰ Built at: {buildTime}</p>
    </div>
  )
}

export default App