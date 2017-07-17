#!/bin/sh
cd blameRepo
mkdir /home/justa/dev/small_blame 2>/dev/null
perl blameRepoFilesMT.pl --verbose --formatBlame=./formatBlame.pl /home/justa/dev/small_token /home/justa/dev/small_blame '\.([ch]|go|md|sh|yml|yaml)$'
