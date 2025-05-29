#!/bin/bash

DEFAULT_FILE="${1:-symlinks-config-default.txt}"
TMPFILE=$(mktemp)

trap 'rm -f "$TMPFILE"' EXIT

./save_symlinks.sh projet "$TMPFILE" && ./compare_symlinks.sh "$TMPFILE" "$DEFAULT_FILE"

