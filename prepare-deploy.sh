#!/bin/bash
set -e

DEPLOY_DIR="deploy"

# Check required files and folders
if [ ! -f "app.R" ]; then
  echo "❌ ERROR: app.R not found in root!"
  exit 1
fi

if [ ! -d "R" ]; then
  echo "❌ ERROR: R directory not found in root!"
  exit 1
fi

# Optional: Check if R scripts exist inside R/
R_FILES=$(ls R/*.R 2>/dev/null || true)
if [ -z "$R_FILES" ]; then
  echo "❌ ERROR: No R scripts found in R/ directory!"
  exit 1
fi

# Clean existing deploy folder
rm -rf "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"

# Copy app.R
cp app.R "$DEPLOY_DIR"

# Copy all R scripts from R/ to deploy root
cp R/*.R "$DEPLOY_DIR"

# Copy www assets (optional)
if [ -d "www" ]; then
  mkdir -p "$DEPLOY_DIR/www"
  cp -r www/* "$DEPLOY_DIR/www/"
fi

echo "Deployment folder prepared at $DEPLOY_DIR"