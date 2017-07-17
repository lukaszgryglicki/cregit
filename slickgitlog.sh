#!/bin/sh
cd slickGitLog
sbt 'run ../kubernetes-token.db /home/justa/dev/kubernetes_token/'
sbt 'run ../kubernetes-original.db /home/justa/dev/kubernetes_original/'
