#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf .venv poetry.lock pyproject.toml

poetry init --name test-poetry-install --python ">=3.10" -n
poetry add git+https://github.com/mfbx9da4/petstore-python-test.git#subdirectory=dist/python
poetry run python -c "from openapi import SDK; print('poetry: Python SDK imported successfully')"

echo "PASS: poetry installation test"
