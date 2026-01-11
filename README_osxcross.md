osxcross setup and usage
=========================

Overview
--------
This documents how to build macOS (`x86_64-apple-darwin`) binaries on Linux using osxcross.

Important: you must supply an Apple SDK tarball extracted from a Mac's Xcode installation. Apple does not permit redistribution of the SDK — you must create the tarball yourself on a Mac and copy it to this machine.

1) Create SDK tarball on a Mac
--------------------------------
On a Mac with Xcode installed run:

```bash
# show SDK path
xcrun --sdk macosx --show-sdk-path

# go to parent and tar up the SDK folder (example)
cd $(xcrun --sdk macosx --show-sdk-path)/..
tar -czf MacOSX_SDK.tar.gz MacOSX.sdk

# copy MacOSX_SDK.tar.gz to your Linux machine
```

2) Run the setup script on Linux
---------------------------------
Place the `MacOSX_SDK.tar.gz` you created into any local path and run the included helper:

```bash
./scripts/setup_osxcross.sh /path/to/MacOSX_SDK.tar.gz
```

The script will:
- clone `osxcross` into `./osxcross` (if not present)
- copy the tarball to `osxcross/tarballs`
- generate a packaged SDK and run `./build.sh`

3) Build the project for macOS
-------------------------------
After the osxcross build completes, add the toolchain to your PATH and build:

```bash
export PATH="${PWD}/osxcross/target/bin:$PATH"
cargo build --release --target x86_64-apple-darwin
```

Notes and troubleshooting
-------------------------
- If `./scripts/setup_osxcross.sh` fails when generating the package, inspect `osxcross/tools` for the helper scripts available in your `osxcross` version.
- Building the SDK requires a valid Xcode SDK; the script does not fetch any Apple components.
- For CI builds, prefer GitHub Actions `macos-latest` runner (we added a workflow) which already provides Xcode and the SDK.
