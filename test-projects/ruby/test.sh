#!/bin/bash
# Test Ruby installation from git URL
# Expected: installs the petstore SDK and requires successfully
set -e

cd "$(dirname "$0")"
rm -rf Gemfile Gemfile.lock vendor .bundle

cat > Gemfile <<GEMFILE
source "https://rubygems.org"
gem "openapi", git: "https://github.com/mfbx9da4/petstore-python-test", glob: "dist/ruby/*.gemspec"
GEMFILE

bundle install
bundle exec ruby -e "require 'openapi'; puts 'Ruby SDK imported successfully'"

echo "PASS: Ruby installation test"
