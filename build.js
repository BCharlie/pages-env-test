#!/usr/bin/env node

/**
 * Branch-aware build script for Cloudflare Pages
 * Loads the correct .env file based on branch and builds the site
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Get branch from environment (Cloudflare Pages sets CF_PAGES_BRANCH)
const branch = process.env.CF_PAGES_BRANCH || process.env.BRANCH || 'main';

// Map branches to environment files
const envMap = {
  'main': '.env.prod',
  'staging': '.env.staging', 
  'dev': '.env.dev'
};

const envFile = envMap[branch] || '.env.prod';

console.log(`🌟 Building for branch: ${branch}`);
console.log(`📦 Using environment file: ${envFile}`);

// Check if env file exists
if (!fs.existsSync(envFile)) {
  console.warn(`⚠️  Environment file ${envFile} not found, using defaults`);
} else {
  // Copy branch-specific env file to .env
  fs.copyFileSync(envFile, '.env');
  console.log(`✅ Loaded ${envFile} -> .env`);
}

// Run the SvelteKit build
console.log('🔨 Building SvelteKit app...');
try {
  execSync('npm run build', { stdio: 'inherit' });
  console.log('✅ Build completed successfully!');
} catch (error) {
  console.error('❌ Build failed:', error.message);
  process.exit(1);
}