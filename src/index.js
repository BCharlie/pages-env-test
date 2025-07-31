export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    
    // Try to serve static assets first
    try {
      const asset = await env.ASSETS.fetch(request);
      if (asset.status !== 404) {
        return asset;
      }
    } catch (e) {
      // Assets not available, continue to fallback
    }
    
    // For SPA routing, serve index.html for non-asset requests
    if (!url.pathname.includes('.')) {
      try {
        const indexRequest = new Request(new URL('/', request.url), request);
        return await env.ASSETS.fetch(indexRequest);
      } catch (e) {
        // Fallback if assets not available
        return new Response('Static assets not found', { status: 404 });
      }
    }
    
    return new Response('Not Found', { status: 404 });
  },
};