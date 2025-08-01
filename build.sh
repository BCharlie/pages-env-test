#!/bin/bash

# Build script for Cloudflare Pages with environment variable injection
# Detects branch and injects appropriate environment variables into HTML

set -e

echo "🌟 Starting build process..."

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

# Create a temporary HTML file with environment variables injected
cp index.html index.html.bak

# Inject environment variables into HTML using sed
sed -i.tmp "s|{{ENV_NAME}}|$ENV_NAME|g" index.html
sed -i.tmp "s|{{API_URL}}|$API_URL|g" index.html
sed -i.tmp "s|{{FEATURE_FLAG}}|$FEATURE_FLAG|g" index.html
sed -i.tmp "s|{{BRANCH}}|$BRANCH|g" index.html

# Clean up temp files
rm -f index.html.tmp

echo "✅ Build completed successfully!"
echo "📄 Environment variables injected into HTML"