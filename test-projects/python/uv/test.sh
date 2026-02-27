#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf .venv uv.lock pyproject.toml

uv init --name test-uv-install
uv add git+https://github.com/mfbx9da4/petstore-python-test.git#subdirectory=dist/python
uv run python -c "from openapi import SDK; print('uv: Python SDK imported successfully')"

echo "PASS: uv installation test"
