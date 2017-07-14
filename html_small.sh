#!/bin/sh
cd prettyPrint
perl ./prettyPrintFilesMT.pl --verbose ../small-slickgitlog.db ../small-persons.db /home/justa/dev/small /home/justa/dev/small_blame /home/justa/dev/cregit_small_html https://github.com/lukaszgryglicki/testing_robot/commit/ '\.([ch]|go|md|sh|yml|yaml)$'
