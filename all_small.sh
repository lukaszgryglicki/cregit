#!/bin/sh
./run_tokenize_small.sh
./slickgitlog_small.sh
./persons_small.sh
./blame_small.sh
./remapcommits_small.sh
./html_small.sh
find /home/justa/dev/cregit_small_html/ -type f -iname "*.html" -exec chmod ugo+r "{}" \;
