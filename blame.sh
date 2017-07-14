#!/bin/sh
cd blameRepo
perl blameRepoFilesMT.pl --verbose --formatBlame=./formatBlame.pl /home/justa/dev/kubernetes /home/justa/dev/kubernetes_blame '\.([ch]|go|md|sh|yaml)$'
