#!/bin/bash
# Test Java installation from git URL
# Note: Java typically uses Maven/Gradle with Maven Central, not git URLs.
# The installationURL for Java is primarily informational (linking to the repo).
# This test verifies the generated project can be built from the repo source.
# Requires Java 21 (Gradle doesn't support Java 26+).
set -e

cd "$(dirname "$0")"

# Use Java 21 via mise
export JAVA_HOME=$(mise where java@21 2>/dev/null)
export PATH="$JAVA_HOME/bin:$PATH"

if [ ! -d /tmp/petstore-java-clone ]; then
    git clone https://github.com/mfbx9da4/petstore-python-test /tmp/petstore-java-clone
fi
cd /tmp/petstore-java-clone/dist/java
./gradlew build

echo "PASS: Java build test"
