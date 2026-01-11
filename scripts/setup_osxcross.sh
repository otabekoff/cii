#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /path/to/MacOSX_SDK.tar.gz"
  exit 1
fi

SDK_TARBALL="$1"
REPO_DIR="${PWD}/osxcross"

if [ ! -f "$SDK_TARBALL" ]; then
  echo "SDK tarball not found: $SDK_TARBALL"
  exit 1
fi

if [ ! -d "$REPO_DIR" ]; then
  git clone https://github.com/tpoechtrager/osxcross.git "$REPO_DIR"
fi

pushd "$REPO_DIR"
mkdir -p tarballs
cp "$SDK_TARBALL" tarballs/

# Generate packaged SDK (the helper script may differ between osxcross versions)
if [ -f ./tools/gen_sdk_package_macports.sh ]; then
  echo "Generating SDK package..."
  UNATTENDED=1 ./tools/gen_sdk_package_macports.sh "tarballs/$(basename "$SDK_TARBALL")"
else
  echo "SDK package generator not found; ensure osxcross version supports packing the SDK"
fi

echo "Building osxcross (this may take a while)..."
./build.sh
popd

echo
echo "osxcross built. To use it in this shell, run (example):"
echo "  export PATH=\"${REPO_DIR}/target/bin:\$PATH\""
echo "Then build your project with:"
echo "  cargo build --release --target x86_64-apple-darwin"
