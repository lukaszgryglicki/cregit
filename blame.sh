#!/bin/sh
cd blameRepo
mkdir /home/justa/dev/kubernetes_blame 2>/dev/null
perl blameRepoFilesMT.pl --verbose --formatBlame=./formatBlame.pl /home/justa/dev/kubernetes /home/justa/dev/kubernetes_blame '\.([ch]|go|md|sh|yml|yaml)$'
