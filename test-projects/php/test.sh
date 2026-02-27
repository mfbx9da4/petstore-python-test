#!/bin/bash
# Test PHP installation from git URL
# Composer VCS repositories require composer.json at the repo root.
# In a monorepo where PHP lives in a subdirectory, this fundamentally
# doesn't work. Users need split repos or Private Packagist.
set -e

cd "$(dirname "$0")"
rm -rf vendor composer.json composer.lock

echo "SKIP: Composer VCS does not support monorepo subdirectories"
echo "The PHP SDK is at dist/php/ but Composer requires composer.json at repo root."
echo "Workarounds: split repos, Private Packagist, or path repositories (local only)."
