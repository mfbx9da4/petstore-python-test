#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf node_modules package.json pnpm-lock.yaml

cat > package.json <<'JSON'
{
  "name": "test-pnpm",
  "version": "1.0.0",
  "dependencies": {
    "openapi": "github:mfbx9da4/petstore-python-test#path:/dist/typescript"
  }
}
JSON

pnpm install

# Verify it resolved from git (not npm registry) by checking lockfile
if grep -q "codeload.github.com/mfbx9da4/petstore-python-test" pnpm-lock.yaml; then
    echo "PASS: pnpm resolved from git with #path: subdirectory"
else
    echo "FAIL: pnpm did not resolve from git URL"
    cat pnpm-lock.yaml
    exit 1
fi

# Note: import test skipped because TS SDK needs build step (tshy)
# and /dist is gitignored. A `prepare` script would fix this.
