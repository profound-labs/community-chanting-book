#!/usr/bin/env bash

# Requires:
# sudo apt-get install inotify-tools
#
# See also:
# https://askubuntu.com/questions/819265/command-to-monitor-file-changes-within-a-directory-and-execute-command

MAIN="main-pt-vol1"

build_pdf() {
    # cat "$MAIN".fir | \
    #     sed '/\\contentsfinish/d' | \
    #     sort > "$MAIN".fir.tmp
    # echo '\\contentsfinish' >> "$MAIN".fir.tmp
    # mv "$MAIN".fir.tmp "$MAIN".fir
    # -g always builds, even when the file didn't change
    latexmk -g -interaction=nonstopmode -halt-on-error -xelatex "$MAIN".tex
}

# Start watcher.
inotifywait -m --event modify --format '%w' ./*.tex ./*.sty ./*.cls ./chapters/portuguese/*.tex | while read -r file ; do
    echo "=== Modified: $file ==="
    build_pdf
done
