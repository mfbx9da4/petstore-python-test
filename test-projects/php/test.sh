#!/bin/bash
# Test PHP installation from git URL
# Expected: installs the petstore SDK
set -e

cd "$(dirname "$0")"
rm -rf vendor composer.json composer.lock

cat > composer.json <<COMPOSER
{
    "require": {
        "openapi/openapi": "dev-main"
    },
    "repositories": [
        {
            "type": "vcs",
            "url": "https://github.com/mfbx9da4/petstore-python-test.git"
        }
    ],
    "minimum-stability": "dev"
}
COMPOSER

composer install
php -r "require 'vendor/autoload.php'; echo 'PHP SDK loaded successfully' . PHP_EOL;"

echo "PASS: PHP installation test"
