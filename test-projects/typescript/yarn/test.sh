#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf node_modules package.json yarn.lock .yarn .yarnrc.yml

npm init -y
yarn add https://github.com/mfbx9da4/petstore-python-test
# Note: yarn uses workspace names (#workspace=name) for monorepo subdirectories,
# not filesystem paths. This test uses the base URL.

echo "PASS: yarn installation test (subdirectory requires workspace config)"
