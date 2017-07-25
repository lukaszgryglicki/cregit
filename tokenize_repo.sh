#!/bin/sh
DEV_PATH=/home/justa/dev
MASK='\.([ch]|go|md|sh|yml|yaml|json)$'
if [ -z "$1" ]
then
	echo "Need argument: repo_path"
	exit 1
fi
REPO=$1

# BFG part (longest)
cd ${DEV_PATH}/tmp

mkdir ${DEV_PATH}/tmp/memo 2>/dev/null
BFG_MEMO_DIR=${DEV_PATH}/tmp/memo; export BFG_MEMO_DIR
BFG_TOKENIZE_CMD="${DEV_PATH}/cregit/tokenize/tokenizeSrcMl.pl --rtokenizer=${DEV_PATH}/rtokenize/rtokenize.sh --go2token=${DEV_PATH}/cregit/tokenize/goTokenizer/gotoken --simpleTokenizer=${DEV_PATH}/cregit/tokenize/text/simpleTokenizer.pl --srcml2token=srcml2token --srcml=srcml --ctags=ctags-exuberant"; export BFG_TOKENIZE_CMD
SBT_OPTS='-Xms100g -Xmx100g -XX:ReservedCodeCacheSize=2048m -XX:MaxMetaspaceSize=25g'; export SBT_OPTS
cd ${DEV_PATH}/bfg-repo-cleaner/
rm perllog.txt rtokenize.log tmpfile* 2>/dev/null
FILE=`find . -iname "*.jar"`
echo 'Running SBT...'
java $SBT_OPTS -jar $FILE "--blob-exec:${DEV_PATH}/cregit/tokenizeByBlobId/tokenBySha.pl=$MASK" --no-blob-protection $REPO

# Rewrite history
echo 'Rewritting history...'
cd $REPO
git reset --hard
git reflog expire --expire=now --all && git gc --prune=now --aggressive
rm -rf ${BFG_MEMO_DIR}/* ${REPO}.bfg-report
