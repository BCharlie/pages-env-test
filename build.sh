#!/bin/bash

# Build script for Cloudflare Pages with React + Vite
# Creates .env file and runs Vite build

set -e

echo "🌟 Starting React + Vite build process..."
echo "📋 Environment variables:"
echo "  CF_PAGES_BRANCH: $CF_PAGES_BRANCH"
echo "  BRANCH: $BRANCH"
echo "  CF_PAGES: $CF_PAGES"

# Detect branch (Cloudflare Pages sets CF_PAGES_BRANCH)
BRANCH=${CF_PAGES_BRANCH:-${BRANCH:-dev}}
echo "📦 Building for branch: $BRANCH"

# Set environment variables based on branch
case $BRANCH in
  "main")
    ENV_NAME="production"
    API_URL="https://api.production.com"
    FEATURE_FLAG="true"
    ;;
  "staging")
    ENV_NAME="staging"
    API_URL="https://api.staging.com"
    FEATURE_FLAG="true"
    ;;
  "dev"|*)
    ENV_NAME="development"
    API_URL="https://api.dev.com"
    FEATURE_FLAG="false"
    ;;
esac

echo "🔧 Environment: $ENV_NAME"
echo "🌐 API URL: $API_URL"
echo "🚩 Feature Flag: $FEATURE_FLAG"

# Create .env file for Vite
echo "📝 Creating .env file..."
cat > .env << EOF
VITE_ENV_NAME=$ENV_NAME
VITE_API_URL=$API_URL
VITE_FEATURE_FLAG=$FEATURE_FLAG
VITE_BRANCH=$BRANCH
EOF

echo "✅ Created .env file:"
cat .env

# Run Vite build
echo "🔨 Running Vite build..."
npm run build:vite

echo "✅ Build completed successfully!"
echo "📦 Built files are in dist/ directory"