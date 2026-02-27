#!/bin/bash
# Test C# installation from git URL
# Note: C# typically uses NuGet for packages, not git URLs.
# The installationURL for C# is primarily informational (linking to the repo).
# This test verifies the generated project can be built from the repo source.
set -e

cd "$(dirname "$0")"
rm -rf test-project

mkdir test-project && cd test-project
dotnet new console

# Add project reference from the cloned repo
if [ ! -d /tmp/petstore-csharp-clone ]; then
    git clone https://github.com/mfbx9da4/petstore-python-test /tmp/petstore-csharp-clone
fi
dotnet add reference /tmp/petstore-csharp-clone/dist/csharp/src/Openapi/Openapi.csproj

dotnet build
echo "PASS: C# build test"
