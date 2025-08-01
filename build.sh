#!/bin/bash

# Build script for Cloudflare Pages with React + Vite
# Uses the correct .env file based on branch

set -e

echo "🌟 Starting React + Vite build process..."
echo "📋 Environment variables:"
echo "  CF_PAGES_BRANCH: $CF_PAGES_BRANCH"
echo "  BRANCH: $BRANCH"
echo "  CF_PAGES: $CF_PAGES"

# Detect branch (Cloudflare Pages sets CF_PAGES_BRANCH)
BRANCH=${CF_PAGES_BRANCH:-${BRANCH:-dev}}
echo "📦 Building for branch: $BRANCH"

# Select the correct .env file based on branch
case $BRANCH in
  "main")
    ENV_FILE=".env.production"
    ;;
  "staging")
    ENV_FILE=".env.staging"
    ;;
  "dev"|*)
    ENV_FILE=".env.dev"
    ;;
esac

echo "📝 Using environment file: $ENV_FILE"

# Check if env file exists
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Environment file $ENV_FILE not found!"
  exit 1
fi

# Copy the correct env file to .env for Vite
cp "$ENV_FILE" .env
echo "✅ Copied $ENV_FILE to .env"

# Show what we're using
echo "🔍 Environment variables:"
cat .env

# Run Vite build
echo "🔨 Running Vite build..."
npm run build:vite

echo "✅ Build completed successfully!"
echo "📦 Built files are in dist/ directory"