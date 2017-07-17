#!/bin/sh
cd remapCommits
sbt 'run ../kubernetes-token.db /home/justa/dev/kubernetes_token'
