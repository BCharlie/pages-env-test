export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    
    // Serve static assets
    try {
      const asset = await env.ASSETS.fetch(request);
      if (asset.status !== 404) {
        return asset;
      }
    } catch (e) {
      // Continue to fallback
    }
    
    // Fallback to index.html for SPA routing
    try {
      const indexRequest = new Request(new URL('/', request.url), request);
      return await env.ASSETS.fetch(indexRequest);
    } catch (e) {
      return new Response('Not Found', { status: 404 });
    }
  },
};