BFG_MEMO_DIR=/tmp/memo; export BFG_MEMO_DIR
BFG_TOKENIZE_CMD='/home/justa/dev/cregit/tokenize/tokenizeSrcMl.pl --go2token=/home/justa/dev/cregit/tokenize/goTokenizer/gotoken --simpleTokenizer=/home/justa/dev/cregit/tokenize/text/simpleTokenizer.pl --srcml2token=srcml2token --srcml=srcml --ctags=ctags-exuberant'; export BFG_TOKENIZE_CMD
cd ../bfg-repo-cleaner/
rm perllog.txt
sbt 'bfg/run --blob-exec:/home/justa/dev/cregit/tokenizeByBlobId/tokenBySha.pl=\.([ch]|go|md|sh|yaml)$ --no-blob-protection /home/justa/dev/kubernetes'
