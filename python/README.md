# Documentation for `python/` (python-build-standalone)

## Image Contents

These images contain a minimal Linux, Python-based runtime built from a
[python-build-standalone](https://github.com/astral-sh/python-build-standalone)
prebuilt tarball instead of the Debian python package.

Supported versions (matching the official CPython support windows):

- Python 3.13 (`python3.13-debian13`)
- Python 3.14 (`python3.14-debian13`)

Each image contains everything in the [base image](../base/README.md),
plus a standalone CPython install under `/python`:

- `/python/bin/python3.X` (with `/python/bin/python` and `/python/bin/python3` symlinks)
- `/python/lib/python3.X/` (standard library)
- `/python/lib/libpython3.X.so.1.0`

No shell, no pip (install dependencies into `site-packages` in a builder stage),
no include files. python-build-standalone builds are relocatable and reference
only glibc at runtime, so no extra Debian packages are needed.

## Usage

The entrypoint of these images is set to `python3.X`, so they expect users to
supply a path to a .py file in the CMD.

See the Python [Hello World](../examples/python3/) directory for an example.

### Compatibility

When using these images in a multi-stage build, use a build image with the same
Python version to avoid ABI-related errors. For example, when targeting
`python3.14-debian13`, use a `python:3.14-slim-trixie` (or python-build-standalone)
build stage.

When building virtual environments, note that the distroless Python path is
`/python/bin/python3.14`. To ensure your virtual environment's internal links
are correct, your build environment should match this path. If your build image
uses a different path, create a symlink during the build stage, e.g.:

```Dockerfile
RUN ln -s /usr/local/bin/python3.14 /python/bin/python3.14
```

### ctypes.util.find_library

Unlike the deb-based `python3` images, these images do **not** ship a pre-generated
`ld.so.cache`, so `ctypes.util.find_library()` returns `None`. Use absolute library
paths or an explicit `ctypes.CDLL("/lib/.../libX.so.Y")` instead.

## Provenance

Python comes from python-build-standalone release `20260807`
(`cpython-3.13.15 / 3.14.7 +20260807-{x86_64,aarch64,s390x,riscv64}-unknown-linux-gnu-install_only.tar.gz`),
pinned in `//private/extensions:python.bzl`. Update via `knife update-python-archives`
(see `knife.d/update_python_archives.sh`).
