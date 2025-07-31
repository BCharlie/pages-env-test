<script>
  import { browser } from '$app/environment';
  
  // Build-time variables from Vite environment
  const buildTime = new Date().toISOString();
  const buildEnv = import.meta.env.VITE_PUBLIC_ENV_NAME || 'development';
  const apiUrl = import.meta.env.VITE_PUBLIC_API_URL || 'https://api.example.com';
  const featureFlag = import.meta.env.VITE_PUBLIC_FEATURE_FLAG || 'false';
</script>

<main>
  <h1>Environment Variables Test - MAIN BRANCH</h1>
  <p>Testing environment variables and build configuration for Cloudflare Workers deployment.</p>
  <p><strong>Current Branch: MAIN (Production)</strong></p>
  
  <div class="env-section">
    <h2>Public Environment Variables</h2>
    <div class="env-grid">
      <div class="env-item">
        <label>Environment:</label>
        <span class="value">{buildEnv}</span>
      </div>
      
      <div class="env-item">
        <label>API URL:</label>
        <span class="value">{apiUrl}</span>
      </div>
      
      <div class="env-item">
        <label>Feature Flag:</label>
        <span class="value {featureFlag === 'true' ? 'enabled' : 'disabled'}">{featureFlag}</span>
      </div>
      
      <div class="env-item">
        <label>Build Time:</label>
        <span class="value">{buildTime}</span>
      </div>
      
      <div class="env-item">
        <label>Browser:</label>
        <span class="value">{browser ? 'Client-side' : 'Server-side'}</span>
      </div>
    </div>
  </div>
  
  <div class="deployment-info">
    <h2>Deployment Information</h2>
    <p>This site demonstrates:</p>
    <ul>
      <li>Environment variable injection at build time</li>
      <li>Different configurations per branch/environment</li>
      <li>Static site generation with SvelteKit</li>
      <li>Cloudflare Workers deployment</li>
    </ul>
  </div>
</main>

<style>
  main {
    max-width: 800px;
    margin: 2rem auto;
    padding: 0 2rem;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  h1 {
    color: #333;
    text-align: center;
    margin-bottom: 1rem;
  }
  
  h2 {
    color: #555;
    border-bottom: 2px solid #eee;
    padding-bottom: 0.5rem;
  }
  
  .env-section {
    background: #f8f9fa;
    padding: 2rem;
    border-radius: 8px;
    margin: 2rem 0;
  }
  
  .env-grid {
    display: grid;
    gap: 1rem;
    margin-top: 1rem;
  }
  
  .env-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem;
    background: white;
    border-radius: 4px;
    border-left: 4px solid #007acc;
  }
  
  .env-item label {
    font-weight: 600;
    color: #333;
  }
  
  .env-item .value {
    font-family: 'Monaco', 'Menlo', monospace;
    background: #f1f3f4;
    padding: 0.25rem 0.5rem;
    border-radius: 3px;
    font-size: 0.9rem;
  }
  
  .value.enabled {
    background: #d4edda;
    color: #155724;
  }
  
  .value.disabled {
    background: #f8d7da;
    color: #721c24;
  }
  
  .deployment-info {
    margin-top: 3rem;
  }
  
  .deployment-info ul {
    line-height: 1.6;
  }
  
  .deployment-info li {
    margin-bottom: 0.5rem;
  }
  
  p {
    line-height: 1.6;
    color: #666;
  }
</style>
