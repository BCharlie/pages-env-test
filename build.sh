#!/bin/bash

# Build script for Cloudflare Pages with environment variable injection
# Detects branch and injects appropriate environment variables into HTML

set -e

echo "🌟 Starting build process..."
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

# Make sure we have the template
if [ ! -f "index.html" ]; then
  echo "❌ index.html not found!"
  exit 1
fi

# Backup original
cp index.html index.html.bak

# Inject environment variables into HTML using sed (compatible with Linux/macOS)
sed -i.tmp "s|{{ENV_NAME}}|$ENV_NAME|g" index.html
sed -i.tmp "s|{{API_URL}}|$API_URL|g" index.html
sed -i.tmp "s|{{FEATURE_FLAG}}|$FEATURE_FLAG|g" index.html
sed -i.tmp "s|{{BRANCH}}|$BRANCH|g" index.html

# Clean up temp files
rm -f index.html.tmp

echo "✅ Build completed successfully!"
echo "📄 Environment variables injected into HTML"

# Show what was injected for debugging
echo "🔍 Verifying injection:"
grep -n "Environment:" index.html || echo "No Environment line found"
grep -n "API URL:" index.html || echo "No API URL line found"