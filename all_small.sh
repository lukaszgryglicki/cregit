#!/bin/sh
cd ..
git clone https://github.com/lukaszgryglicki/testing_robot.git
mv testing_robot small
cd cregit
./run_tokenize_small.sh
./slickgitlog_small.sh
./persons_small.sh
./blame_small.sh
./remapcommits_small.sh
./html_small.sh
rm -rf prettyPrint/tmpfile*
find /home/justa/dev/cregit_small_html/ -type f -iname "*.html" -exec chmod ugo+r "{}" \;
