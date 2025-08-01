# Cloudflare Pages Multi-Branch Demo

React + Vite app demonstrating per-branch deployments with custom domains and environment variables.

## Live Demos

| Branch | Domain |
|--------|--------|
| `main` | [prod.charliebrown.uk](https://prod.charliebrown.uk) |
| `staging` | [stage.charliebrown.uk](https://stage.charliebrown.uk) |
| `dev` | [dev.charliebrown.uk](https://dev.charliebrown.uk) |

## Setup

```bash
git clone git@github.com:BCharlie/pages-env-test.git
cd pages-env-test
npm install
npm run dev
```

## Cloudflare Pages Configuration

1. Connect GitHub repo to Cloudflare Pages
2. Build settings:
   - **Build command**: `npm run build:$CF_PAGES_BRANCH`
   - **Build output directory**: `dist`
3. Add custom domains for each branch

## Scripts

- `npm run dev` - Development server
- `npm run build` - Local build (uses `.env.local`)
- `npm run build:main` - Production build
- `npm run build:staging` - Staging build  
- `npm run build:dev` - Development build
- `npm run preview` - Preview build

## Environment Files

- `.env.local` - Local development
- `.env.development` - Dev branch
- `.env.staging` - Staging branch  
- `.env.production` - Main branch

All variables must be prefixed with `VITE_` to be available in the React app.

## How It Works

Cloudflare Pages substitutes `$CF_PAGES_BRANCH` with the actual branch name, running the corresponding `build:{branch}` script which loads the matching `.env.{mode}` file via Vite's `--mode` flag.
