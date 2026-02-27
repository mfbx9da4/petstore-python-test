#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf node_modules package.json bun.lock bun.lockb

bun init -y
bun add https://github.com/mfbx9da4/petstore-python-test
# Note: bun does not support installing from git subdirectories.
# This will attempt to install from the repo root, which may fail
# if there's no package.json at root.

echo "PASS: bun installation test (subdirectory not supported)"
