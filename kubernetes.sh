#!/bin/sh
REPO=kubernetes
MASK='\.([ch]|go|md|sh|yml|yaml|json)$'

# Clean up
echo 'Cleaning up...'
rm -rf /tmp/tmp.* /home/justa/dev/$REPO /home/justa/dev/${REPO}_token /home/justa/dev/${REPO}_blame /home/justa/dev/cregit_${REPO}_html /home/justa/dev/${REPO}_memo /home/justa/dev/${REPO}_token.bfg-report ${REPO}-*.db ${REPO}-*.xls
cd ..
# git clone https://github.com/lukaszgryglicki/testing_robot.git
# mv testing_robot ${REPO}_original
cp -R ${REPO}_original ${REPO}_token

# BFG part (longest)
cd cregit
mkdir /home/justa/dev/${REPO}_memo 2>/dev/null
BFG_MEMO_DIR=/home/justa/dev/${REPO}_memo; export BFG_MEMO_DIR
BFG_TOKENIZE_CMD='/home/justa/dev/cregit/tokenize/tokenizeSrcMl.pl --rtokenizer=/home/justa/dev/rtokenize/rtokenize.sh --go2token=/home/justa/dev/cregit/tokenize/goTokenizer/gotoken --simpleTokenizer=/home/justa/dev/cregit/tokenize/text/simpleTokenizer.pl --srcml2token=srcml2token --srcml=srcml --ctags=ctags-exuberant'; export BFG_TOKENIZE_CMD
SBT_OPTS='-Xms100g -Xmx100g -XX:ReservedCodeCacheSize=2048m -XX:MaxMetaspaceSize=25g'; export SBT_OPTS
cd ../bfg-repo-cleaner/
rm perllog.txt rtokenize.log tmpfile* 2>/dev/null
echo 'Uncomment next two lines to have BFG compiled in every run'
# sbt clean
# sbt bfg/assembly
FILE=`find . -iname "*.jar"`
echo 'Running SBT...'
java $SBT_OPTS -jar $FILE "--blob-exec:/home/justa/dev/cregit/tokenizeByBlobId/tokenBySha.pl=$MASK" --no-blob-protection /home/justa/dev/${REPO}_token

# Rewrite history
echo 'Rewritting history...'
cd /home/justa/dev/${REPO}_token
git reset --hard
git reflog expire --expire=now --all && git gc --prune=now --aggressive
cd /home/justa/dev/cregit

# Slick Git Log
echo 'SLick Git Log...'
cd slickGitLog
sbt "run ../${REPO}-token.db /home/justa/dev/${REPO}_token/"
sbt "run ../${REPO}-original.db /home/justa/dev/${REPO}_original/"
cd ..

# Remap commits
echo 'Remap commits...'
cd remapCommits
sbt "run ../${REPO}-token.db /home/justa/dev/${REPO}_token"
cd ..

# Persons DB
echo 'Persons DB...'
cd persons
sbt "run /home/justa/dev/${REPO}_token ../${REPO}-persons.xls ../${REPO}-persons.db"
cd ..

# Blame
echo 'Blame...'
cd blameRepo
mkdir /home/justa/dev/${REPO}_blame 2>/dev/null
perl blameRepoFilesMT.pl --verbose --formatBlame=./formatBlame.pl /home/justa/dev/${REPO}_token /home/justa/dev/${REPO}_blame "$MASK"
cd ..

# HTML generation
echo 'HTML...'
cd prettyPrint
mkdir /home/justa/dev/cregit_${REPO}_html 2>/dev/null
perl ./prettyPrintFilesMT.pl --verbose ../${REPO}-token.db ../${REPO}-persons.db /home/justa/dev/${REPO}_original /home/justa/dev/${REPO}_blame /home/justa/dev/cregit_${REPO}_html https://github.com/lukaszgryglicki/testing_robot/commit/ "$MASK"
cd ..

echo 'Final permissions...'
# Apache permissions
rm -rf prettyPrint/tmpfile*
find /home/justa/dev/cregit_${REPO}_html/ -type f -iname "*.html" -exec chmod ugo+r "{}" \;
find /home/justa/dev/${REPO}_token/ -type f -iname "*.html" -exec chmod ugo+r "{}" \;

echo 'All done.'
