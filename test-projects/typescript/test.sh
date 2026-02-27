#!/bin/bash
# Test TypeScript installation from git URL
# Expected: installs the petstore SDK and imports successfully
set -e

cd "$(dirname "$0")"
rm -rf node_modules package.json package-lock.json

npm init -y
npm add https://github.com/mfbx9da4/petstore-python-test#path:dist/typescript
node -e "const { SDK } = require('openapi'); console.log('TypeScript SDK imported successfully')"

echo "PASS: TypeScript installation test"
