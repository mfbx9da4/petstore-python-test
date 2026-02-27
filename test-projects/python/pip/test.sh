#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf .venv

python3 -m venv .venv
source .venv/bin/activate
pip install "git+https://github.com/mfbx9da4/petstore-python-test.git#subdirectory=dist/python"
python3 -c "from openapi import SDK; print('pip: Python SDK imported successfully')"

echo "PASS: pip installation test"
