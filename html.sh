#!/bin/sh
cd prettyPrint
perl ./prettyPrintFilesMT.pl --verbose ../kubernetes-slickgitlog.db ../kubernetes-persons.db /home/justa/dev/kubernetes /home/justa/dev/kubernetes_blame /home/justa/dev/cregit_k8s_html https://github.com/kubernetes/kubernetes/commit/ '\.([ch]|go|md|sh|yml|yaml)$'
