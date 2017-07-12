#!/bin/bash

VERSION=2.66
PRODUCT=jenkins
ORIGINALREPO=../origina.repo/jenkins


CREATE_TOKEN_REPO=no
CREATE_PERSONS=no
CREATE_DBS=no
CREATE_BLAME=no
CREATE_HTML=yes

CREGIT=/home/dmg/git.dmg/cregit-scala

CREGITDB=token.db
ORIGINALDB=line.db
PERSONSDB=persons.db

TOKENREPO=token

export BFG_MEMO_DIR=`pwd`/memo
BLAME_DIR=`pwd`/blame
EXTENSION='\.java$'
HTML_DIR=`pwd`/html
COMMIT_URL=https://github.com/jenkinsci/jenkins/commit/

error_exit()
{

#   ----------------------------------------------------------------
#   Function for exit due to fatal program error
#       Accepts 1 argument:
#           string containing descriptive error message
#   ---------------------------------------------------------------- 

    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    exit 1
}


if [ ! -d "$ORIGINALREPO" ]; then
    # Control will enter here if $DIRECTORY doesn't exist.
    error_exit "Error! original repo does not exist [$ORIGINALREPO]" 
fi

if [ ! -d "$TOKENREPO" ]; then
    # Control will enter here if $DIRECTORY doesn't exist.
    error_exit "Error! token repo does not exist [$TOKENREPO]" 
fi

if [ "$CREATE_TOKEN_REPO" = "yes" ]; then 
    
    if [ ! -d "$BFG_MEMO_DIR" ]; then
        # Control will enter here if $DIRECTORY doesn't exist.
        mkdir $BFG_MEMO_DIR || error_exit
    fi

    cd $TOKENREPO || error_exit "Error! token repo does not exist" 

    export BFG_TOKENIZE_CMD='/home/dmg/git.dmg/cregit-scala/tokenize/tokenizeSrcMl.pl --srcml2token=/home/dmg/git.dmg/cregit-scala/tokenize/srcMLtoken/srcml2token --srcml=srcml --ctags=ctags-exuberant'

    java -jar ${CREGIT}/jars/bfg.jar '--blob-exec:/home/dmg/git.dmg/cregit-scala/tokenizeByBlobId/tokenBySha.pl=\.java$' --no-blob-protection

    git reset --hard
    git reflog expire --expire=now --all && git gc --prune=now --aggressive

    cd ..
fi
if [ "$CREATE_DBS" = "yes" ]; then 
  java -jar ${CREGIT}/jars/slickGitLog.jar $CREGITDB $TOKENREPO
  java -jar ${CREGIT}/jars/slickGitLog.jar $ORIGINALDB $ORIGINALREPO
  java -jar ${CREGIT}/jars/remapcommits.jar $CREGITDB $TOKENREPO
fi

if [ "$CREATE_PERSONS" = "yes" ]; then 
   java -jar ${CREGIT}/jars/persons.jar $TOKENREPO persons.xls $PERSONSDB

   printf "drop table persons;\n" | sqlite3 $PERSONSDB
   printf "create table persons(personid text primary key not null, personname text);\n" | sqlite3 $PERSONSDB
   printf "insert into persons(personid) select distinct personid from emails;\n" | sqlite3 $PERSONSDB

fi

if [ "$CREATE_BLAME" = "yes" ]; then 
    if [ ! -d "$BLAME_DIR" ]; then
        # Control will enter here if $DIRECTORY doesn't exist.
        mkdir $BLAME_DIR || error_exit
    fi

   perl ${CREGIT}/blameRepo/blameRepoFiles.pl --verbose $TOKENREPO $BLAME_DIR $EXTENSION
fi

if [ "$CREATE_HTML" = "yes" ]; then 
    if [ ! -d "$HTML_DIR" ]; then
        # Control will enter here if $DIRECTORY doesn't exist.
        mkdir $HTML_DIR || error_exit
    fi

    perl ${CREGIT}/prettyPrint/prettyPrintFiles.pl --verbose $CREGITDB $PERSONSDB $ORIGINALREPO $BLAME_DIR $HTML_DIR $COMMIT_URL $EXTENSION
fi
