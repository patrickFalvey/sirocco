#!/usr/bin/env bash


if [ $# -eq 0 ]
then
  INDEXINGTYPE="FULLINDEX"
elif [ "$1" != "FULLINDEX" ] && [ "$1" != "TOPSENTIMENTS" ]
then
  echo "Invalid parameter value. Use one of {FULLINDEX | TOPSENTIMENTS}"
  exit 1
else
  INDEXINGTYPE=$1
fi

MAVEN_OPTS="-Xmx2g -Xss4m"

INPUT_DIR='./src/test/resources/in'
OUTPUT_DIR='./src/test/resources/out'

for f in $(find $INPUT_DIR -name '[^.]*.txt'); do
    FILENAME=$(basename $f)
    UPPER_DIR=$(basename $(dirname $f))
    NEWNAME=$OUTPUT_DIR"/"$UPPER_DIR"/"$FILENAME
    #echo $FILENAME $UPPER_DIR $NEWNAME
    mvn exec:java \
        -Dexec.mainClass=sirocco.cmdline.CLI \
        -Dexec.args="Indexer -inputFile \"$f\" -outputFile \"$NEWNAME\" -indexingType FULLINDEX"

done


