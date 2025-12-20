#!/usr/bin/env bash

# Local build script for BlueBuild images
# Usage: ./build-local.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${SCRIPT_DIR}"
docker run --rm \
  --privileged \
  --pull=always \
  -v "${PWD}:/bluebuild:z" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --entrypoint /usr/bin/bluebuild \
  ghcr.io/blue-build/cli:latest \
  build /bluebuild/recipes/recipe.yml

echo ""
echo "Build complete!"
