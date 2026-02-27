#!/bin/bash
# Test Python installation from git URL
# Expected: installs the petstore SDK and imports successfully
set -e

cd "$(dirname "$0")"
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate

pip install "git+https://github.com/mfbx9da4/petstore-python-test.git#subdirectory=dist/python"
python3 -c "from openapi import SDK; print('Python SDK imported successfully')"

echo "PASS: Python installation test"
