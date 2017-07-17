#!/bin/sh
cd slickGitLog
sbt 'run ../small-token.db /home/justa/dev/small_token/'
sbt 'run ../small-original.db /home/justa/dev/small_original/'
