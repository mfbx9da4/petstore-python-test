#!/bin/bash
set -e
cd "$(dirname "$0")"
rm -rf .venv poetry.lock pyproject.toml

POETRY="${POETRY_BIN:-$(mise where poetry@2.1.1 2>/dev/null)/bin/poetry}"

$POETRY init --name test-poetry-install --python ">=3.10" -n
$POETRY add git+https://github.com/mfbx9da4/petstore-python-test.git#subdirectory=dist/python
$POETRY run python -c "from openapi import SDK; print('poetry: Python SDK imported successfully')"

echo "PASS: poetry installation test"
