root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# generate manual
doc:
  typst compile docs/manual.typ docs/manual.pdf
  typst compile docs/thumbnail.typ thumbnail-light.svg
  typst compile --input theme=dark docs/thumbnail.typ thumbnail-dark.svg

# build all typst files to find compile errors
build:
  #!/usr/bin/env bash
  set -euo pipefail
  status=0
  while IFS= read -r -d '' file; do
    echo "building $file"
    if ! typst compile -f pdf "$file" /dev/null; then
      status=1
    fi
  done < <(find . -name '*.typ' -print0 | sort -z)
  exit $status

# run test suite
test *args:
  tt run {{ args }}

# update test cases
update *args:
  tt update {{ args }}

# package the library into the specified destination folder
package target:
  ./scripts/package "{{target}}"

# install the library with the "@local" prefix
install: (package "@local")

# install the library with the "@preview" prefix (for pre-release testing)
install-preview: (package "@preview")

[private]
remove target:
  ./scripts/uninstall "{{target}}"

# uninstalls the library from the "@local" prefix
uninstall: (remove "@local")

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview: (remove "@preview")

# run ci suite
ci: test doc
