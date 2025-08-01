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
    VITE_MODE="production"
    ;;
  "staging")
    ENV_FILE=".env.staging"
    VITE_MODE="staging"
    ;;
  "dev"|*)
    ENV_FILE=".env.development"
    VITE_MODE="development"
    ;;
esac

echo "📝 Using environment file: $ENV_FILE"
echo "🎯 Vite mode: $VITE_MODE"

# Check if env file exists
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Environment file $ENV_FILE not found!"
  exit 1
fi

# Show what we're using
echo "🔍 Environment variables from $ENV_FILE:"
cat "$ENV_FILE"

# Run Vite build with specific env file
echo "🔨 Running Vite build with $ENV_FILE..."
npx vite build --mode $VITE_MODE --envDir . --envPrefix VITE_

echo "✅ Build completed successfully!"
echo "📦 Built files are in dist/ directory"