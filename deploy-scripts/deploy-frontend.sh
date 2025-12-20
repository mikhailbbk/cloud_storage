#!/bin/bash
set -e

echo "🚀 Starting frontend deployment..."

cd /opt/cloud_storage/frontend

# Check if package.json exists
if [ ! -f "package.json" ]; then
    echo "⚠️ package.json not found. Skipping frontend build."
    exit 0
fi

# Install dependencies and build
echo "Installing dependencies..."
npm ci --silent

echo "Building frontend..."
npm run build

echo "✅ Frontend deployment completed!"