#!/bin/sh
./tokenize/tokenizeSrcMl.pl --go2token=./tokenize/goTokenizer/gotoken --simpleTokenizer=./tokenize/text/simpleTokenizer.pl --srcml2token=srcml2token --srcml=srcml --ctags=ctags-exuberant --language=Go controller.go controller.tokens
