#!/bin/sh
REPO=small
MASK='\.([ch]|go|md|sh|yml|yaml|json)$'

# HTML generation
echo 'HTML...'
cd prettyPrint
mkdir /home/justa/dev/cregit_${REPO}_html 2>/dev/null
perl ./prettyPrintFilesMT.pl --verbose ../${REPO}-token.db ../${REPO}-persons.db /home/justa/dev/${REPO}_original /home/justa/dev/${REPO}_blame /home/justa/dev/cregit_${REPO}_html https://github.com/lukaszgryglicki/testing_robot/commit/ "$MASK"
cd ..
