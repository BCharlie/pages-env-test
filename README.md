# Cloudflare Pages Multi-Branch Demo

A demonstration of Cloudflare Pages with **per-branch deployments**, **custom domains**, and **environment-specific configuration** using React + Vite.

## 🌟 Features

- **3 Branch Setup**: `main`, `staging`, `dev` branches with automatic deployments
- **Custom Domains**: Each branch deploys to its own domain
- **Environment Variables**: Branch-specific configuration using Vite's native env system
- **React + Vite**: Modern frontend stack with fast builds
- **Bash Build Script**: Intelligent branch detection and environment loading

## 🚀 Live Demos

| Branch | Environment | Domain | Status |
|--------|-------------|---------|---------|
| `main` | Production | [prod-test.charliebrown.uk](https://prod-test.charliebrown.uk) | ✅ |
| `staging` | Staging | [stage-test.charliebrown.uk](https://stage-test.charliebrown.uk) | ✅ |
| `dev` | Development | [dev-test.charliebrown.uk](https://dev-test.charliebrown.uk) | ✅ |

## 📁 Project Structure

```
├── src/
│   ├── App.jsx          # Main React component
│   ├── App.css          # Styling
│   └── main.jsx         # Vite entry point
├── build.sh             # Branch-aware build script
├── .env.production      # Production environment variables
├── .env.staging         # Staging environment variables
├── .env.development     # Development environment variables
├── package.json         # Dependencies and scripts
├── vite.config.js       # Vite configuration
└── index.html           # HTML template
```

## 🔧 How It Works

### 1. Branch Detection
The `build.sh` script automatically detects the current branch using Cloudflare Pages' `CF_PAGES_BRANCH` environment variable:

```bash
BRANCH=${CF_PAGES_BRANCH:-${BRANCH:-dev}}
```

### 2. Environment Loading
Based on the detected branch, the script selects the appropriate environment file and Vite mode:

```bash
case $BRANCH in
  "main")
    VITE_MODE="production"    # Loads .env.production
    ;;
  "staging")
    VITE_MODE="staging"       # Loads .env.staging
    ;;
  "dev"|*)
    VITE_MODE="development"   # Loads .env.development
    ;;
esac
```

### 3. Vite Build
The script runs Vite with the appropriate mode, which automatically loads the correct `.env.{mode}` file:

```bash
npx vite build --mode $VITE_MODE
```

### 4. Environment Variables
Each environment file contains `VITE_` prefixed variables that are automatically exposed to the React app:

```bash
# .env.development
VITE_ENV_NAME=development
VITE_API_URL=https://api.dev.com
VITE_FEATURE_FLAG=false
VITE_BRANCH=dev
```

## 🏗️ Setup Instructions

### 1. Clone and Install
```bash
git clone <repository-url>
cd workers
npm install
```

### 2. Cloudflare Pages Setup
1. Connect your GitHub repository to Cloudflare Pages
2. Configure build settings:
   - **Build command**: `npm run build`
   - **Build output directory**: `dist`
3. Set up custom domains for each branch in the Cloudflare dashboard

### 3. Custom Domain Configuration
For each branch, add a custom domain in Cloudflare Pages:
- `main` → `prod-test.charliebrown.uk`
- `staging` → `stage-test.charliebrown.uk`  
- `dev` → `dev-test.charliebrown.uk`

### 4. Environment Variables
The environment variables are automatically loaded from the `.env.{mode}` files. No additional Cloudflare Pages environment variable configuration is needed.

## 📝 Package.json Scripts

```json
{
  "scripts": {
    "dev": "vite",
    "build": "chmod +x build.sh && ./build.sh",
    "build:vite": "vite build",
    "preview": "vite preview"
  }
}
```

## 🔍 Build Process

1. **Branch Detection**: Script identifies current branch from `CF_PAGES_BRANCH`
2. **Environment Selection**: Chooses appropriate `.env.{mode}` file
3. **Vite Mode**: Runs `vite build --mode {mode}`
4. **Automatic Loading**: Vite loads environment variables with `VITE_` prefix
5. **React Build**: Creates optimized production build in `dist/`

## 🌐 Environment Variables

| Variable | Development | Staging | Production |
|----------|-------------|---------|------------|
| `VITE_ENV_NAME` | development | staging | production |
| `VITE_API_URL` | api.dev.com | api.staging.com | api.production.com |
| `VITE_FEATURE_FLAG` | false | true | true |
| `VITE_BRANCH` | dev | staging | main |

## 🚦 Deployment Flow

```mermaid
graph LR
    A[Push to Branch] --> B[Cloudflare Pages Webhook]
    B --> C[CF_PAGES_BRANCH Detection]
    C --> D[Select .env.{mode}]
    D --> E[Vite Build --mode]
    E --> F[Deploy to Custom Domain]
```

## 🛠️ Local Development

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview build
npm run preview
```

## 🎯 Key Benefits

1. **Zero Configuration**: Environment variables work automatically
2. **Branch Isolation**: Each branch has its own configuration
3. **Custom Domains**: Professional URLs for each environment
4. **Fast Builds**: Vite's optimized build process
5. **Type Safety**: Vite provides TypeScript support for env variables

## 📋 Troubleshooting

### Build Fails
- Check that `build.sh` has execute permissions: `chmod +x build.sh`
- Verify `.env.{mode}` files exist for your branch

### Wrong Environment Variables
- Ensure variables are prefixed with `VITE_`
- Check that the correct `.env.{mode}` file is being loaded in build logs

### Custom Domain Issues
- Verify DNS settings in Cloudflare
- Check that custom domain is properly configured in Pages dashboard

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test across all environments
5. Submit a pull request

## 📄 License

MIT License - feel free to use this as a template for your own projects!

---

**Built with ❤️ using Cloudflare Pages, React, and Vite**
