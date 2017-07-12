BFG_MEMO_DIR=/tmp/memo
BFG_TOKENIZE_CMD='/home/justa/dev/cregit/tokenize/tokenizeSrcMl.pl --srcml2token=srcml2token --srcml=srcml --ctags=ctags-exuberant'
java -jar bfg-cregit.jar '--blob-exec:/home/justa/dev/cregit/tokenizeByBlobId/tokenBySha.pl=.[ch]$' --no-blob-protection /home/justa/dev/kubernetes
