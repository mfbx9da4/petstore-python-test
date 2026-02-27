#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf node_modules package.json package-lock.json

npm init -y

# npm ?subdir= support requires pacote >= 21.2.0 (shipped Feb 2026).
# npm 11.6.0 bundles pacote 21.0.0 so this doesn't work yet.
# Once npm updates to pacote 21.2.0+, this should work:
#   npm add git+https://github.com/mfbx9da4/petstore-python-test.git?subdir=dist/typescript

PACOTE_VERSION=$(npm ls pacote --json 2>/dev/null | grep '"version"' | head -1 | grep -o '[0-9.]*')
echo "pacote version: ${PACOTE_VERSION:-unknown}"
echo "SKIP: npm ?subdir= requires pacote >= 21.2.0 (have $PACOTE_VERSION)"
echo "URL: git+https://github.com/mfbx9da4/petstore-python-test.git?subdir=dist/typescript"
