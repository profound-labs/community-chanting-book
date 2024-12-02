#!/usr/bin/env bash

set -e

# without a specific path, it will use the binary installed by cargo
MDBOOK_EPUB_BIN=~/lib/mdbook-gambhiro/mdbook-epub-gambhiro-0.4.41

EBOOK_NAME="Chanting Book - Volume One"
EPUB_FILE="$EBOOK_NAME.epub"
MOBI_FILE="$EBOOK_NAME.mobi"

cd chapters/english/markdown/

$MDBOOK_EPUB_BIN --standalone

cd -

cd book/
~/bin/epubcheck "./$EPUB_FILE"

~/lib/kindlegen/kindlegen "./$EPUB_FILE" -dont_append_source -c1 -verbose

echo "OK"
