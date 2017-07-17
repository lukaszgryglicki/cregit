#!/bin/sh
cd ..
# git clone https://github.com/kubernetes/kubernetes.git
# mv kubernetes kubernetes_original
cp -R kubernetes_original kubernetes_token
cd cregit
./run_tokenize.sh
./slickgitlog.sh
./remapcommits.sh
./persons.sh
./blame.sh
./html.sh
rm -rf prettyPrint/tmpfile*
find /home/justa/dev/cregit_k8s_html/ -type f -iname "*.html" -exec chmod ugo+r "{}" \;
