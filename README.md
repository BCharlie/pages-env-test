# Cloudflare Pages Multi-Branch Demo

React + Vite app demonstrating per-branch deployments with custom domains and environment variables.

## Live Demos

| Branch | Domain |
|--------|--------|
| `main` | [prod-test.charliebrown.uk](https://prod-test.charliebrown.uk) |
| `staging` | [stage-test.charliebrown.uk](https://stage-test.charliebrown.uk) |
| `dev` | [dev-test.charliebrown.uk](https://dev-test.charliebrown.uk) |

## Setup

```bash
git clone <repository-url>
cd workers
npm install
npm run dev
```

## Cloudflare Pages Configuration

1. Connect GitHub repo to Cloudflare Pages
2. Build settings:
   - **Build command**: `npm run build:pages`
   - **Build output directory**: `dist`
3. Add custom domains for each branch

## Scripts

- `npm run dev` - Development server
- `npm run build` - Local build (uses `.env.local`)
- `npm run build:pages` - Branch-aware build for Cloudflare Pages
- `npm run preview` - Preview build

## Environment Files

- `.env.local` - Local development
- `.env.development` - Dev branch
- `.env.staging` - Staging branch  
- `.env.production` - Main branch

All variables must be prefixed with `VITE_` to be available in the React app.

## How It Works

The `build.sh` script detects the current branch via `CF_PAGES_BRANCH` and runs Vite with the appropriate mode, automatically loading the correct `.env.{mode}` file.
