#!/bin/sh
cd blameRepo
perl blameRepoFiles.pl --verbose --formatBlame=./formatBlame.pl /home/justa/dev/kubernetes /home/justa/dev/kubernetes_blame '\.([ch]|go|md|yaml)$'
