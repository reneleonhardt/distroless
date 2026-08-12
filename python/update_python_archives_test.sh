#!/usr/bin/env bash
# Hermetic smoke test for the python updater's parser functions.
# Verifies the committed matrix (python/config.bzl) and the extension
# (private/extensions/python.bzl) stay consistent - no network, no fixtures.
set -euo pipefail

cd "$TEST_SRCDIR/${TEST_WORKSPACE:-_main}"

source knife.d/update_python_archives.sh

minors=$(get_python_minors | tr '\n' ' ')
[ "$minors" = "3.13 3.14 " ] || { echo "unexpected minors: [$minors]"; exit 1; }

for minor in $(get_python_minors); do
  for arch in $(get_python_archs "$minor"); do
    version=$(current_version "$minor" "$arch")
    [ -n "$version" ] || { echo "missing version for ${minor}_${arch}"; exit 1; }
  done
done

echo "update_python_archives parsing OK"
