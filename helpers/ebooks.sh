#!/usr/bin/env bash

set -e

TOML_PATH="$1"
TOML_DIR=$(dirname "$1")

EBOOK_NAME=$(./helpers/get_toml_key.py "$TOML_PATH" "book.title")
MARKDOWN_DIR="$TOML_DIR/$(./helpers/get_toml_key.py "$TOML_PATH" "book.src")/"
BUILD_DIR="$TOML_DIR/$(./helpers/get_toml_key.py "$TOML_PATH" "build.build-dir")/"

# without a specific path, it will use the binary installed by cargo
MDBOOK_EPUB_BIN=~/lib/mdbook-gambhiro/mdbook-epub-gambhiro-0.4.41

EPUB_FILE="$EBOOK_NAME.epub"
MOBI_FILE="$EBOOK_NAME.mobi"

cd "$MARKDOWN_DIR"

$MDBOOK_EPUB_BIN --standalone

cd -

cd "$BUILD_DIR"
~/bin/epubcheck "./$EPUB_FILE"

~/lib/kindlegen/kindlegen "./$EPUB_FILE" -dont_append_source -c1 -verbose

echo "OK"

