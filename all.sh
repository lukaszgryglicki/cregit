#!/bin/sh
./run_tokenize.sh
./slickgitlog.sh
./persons.sh
./blame.sh
./remapcommits.sh
./html.sh
rm -rf prettyPrint/tmpfile*
find /home/justa/dev/cregit_k8s_html/ -type f -iname "*.html" -exec chmod ugo+r "{}" \;
