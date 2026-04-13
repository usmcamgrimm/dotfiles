#!/bin/bash
set -euo

echo "[+] Removing old dist..."
rm -rf dist

echo "[+] Building site locally..."
rm -rf build
parklife build

echo "[+] Build -->> dist"
mv build dist

echo "[+] Copying build-assets into dist..."
mkdir -p dist/assets
cp -r build-assets/* dist/assets/

echo "[+] Checking for CSS and images..."
echo "🔍 Checking for CSS and images..."
if [ -z "$(find dist/assets -type f -name '*.css')" ]; then
    echo "❌ ERROR: No CSS files found in dist/assets."
    exit 1
fi

if [ -z "$(find dist/assets -type f \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.gif' \))" ]; then
    echo "❌ ERROR: No image files found in dist/assets."
    exit 1
fi

echo "[+] Build-assets check passed!"

echo "[+] Deploying build to Netlify..."
netlify deploy --prod --dir=dist --debug

echo "[+] Site deployed successfully!"