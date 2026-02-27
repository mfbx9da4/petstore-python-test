#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf node_modules package.json pnpm-lock.yaml

npm init -y
pnpm add https://github.com/mfbx9da4/petstore-python-test#path:dist/typescript
node -e "const { SDK } = require('openapi'); console.log('pnpm: TypeScript SDK imported successfully')"

echo "PASS: pnpm installation test"
