export default {
  async fetch(request, env, ctx) {
    const html = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Workers Test - DEV BRANCH</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 40px; background: #f0f8ff; }
    .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h1 { color: #333; border-bottom: 3px solid #007acc; padding-bottom: 10px; }
    .branch { background: #e7f3ff; padding: 15px; border-left: 4px solid #007acc; margin: 20px 0; }
    .url { color: #666; font-family: monospace; background: #f5f5f5; padding: 5px; border-radius: 3px; }
  </style>
</head>
<body>
  <div class="container">
    <h1>Cloudflare Workers Test</h1>
    <div class="branch">
      <h2>🚀 DEV BRANCH</h2>
      <p>This is the <strong>development</strong> environment</p>
      <p class="url">dev-test.charliebrown.uk</p>
    </div>
    <p>✅ Worker deployed successfully!</p>
    <p>🌍 URL: ${request.url}</p>
    <p>⏰ Time: ${new Date().toISOString()}</p>
  </div>
</body>
</html>`;
    
    return new Response(html, {
      headers: { 'Content-Type': 'text/html' }
    });
  },
};