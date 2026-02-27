#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf node_modules package.json package-lock.json

npm init -y
npm add git+https://github.com/mfbx9da4/petstore-python-test.git?subdir=dist/typescript
node -e "const { SDK } = require('openapi'); console.log('npm: TypeScript SDK imported successfully')"

echo "PASS: npm installation test"
