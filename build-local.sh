#!/usr/bin/env bash

# Local build script for BlueBuild images
# Usage: ./build-local.sh [recipe]
#   ./build-local.sh          - builds non-NVIDIA (default)
#   ./build-local.sh nvidia   - builds NVIDIA version
#   ./build-local.sh all      - builds both

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

build_image() {
    local recipe=$1
    local name=$2

    echo "Building ${name}..."

    # Remove existing image to force rebuild
    docker rmi "${name}:latest" 2>/dev/null || true
    docker rmi "localhost/${name}:latest" 2>/dev/null || true

    docker run --rm \
      --privileged \
      --pull=always \
      -v "${PWD}:/bluebuild:z" \
      -v /var/run/docker.sock:/var/run/docker.sock \
      --entrypoint /usr/bin/bluebuild \
      ghcr.io/blue-build/cli:latest \
      build "/bluebuild/recipes/${recipe}"

    echo "${name} build complete!"
}

case "${1:-}" in
    nvidia)
        build_image "recipe-nvidia.yml" "bluebuild-andersns-desktop-nvidia"
        ;;
    all)
        build_image "recipe.yml" "bluebuild-andersns-desktop"
        build_image "recipe-nvidia.yml" "bluebuild-andersns-desktop-nvidia"
        ;;
    *)
        build_image "recipe.yml" "bluebuild-andersns-desktop"
        ;;
esac

echo ""
echo "Build complete!"
