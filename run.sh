#!/bin/bash

# move to current directory
ABSPATH=$(cd "$(dirname "$0")"; pwd)
echo $ABSPATH
cd $ABSPATH

#list of languages and nodes
LANGUAGES=( en )
NIDS=( 36546 )

LANGUAGE_COUNT=${#LANGUAGES[@]}
INDEX=0

while [ "$INDEX" -lt "$LANGUAGE_COUNT" ]
do
    LANGUAGE=${LANGUAGES[$INDEX]}
    NID=${NIDS[$INDEX]}
    PDFILE=MuseScore-${LANGUAGE}.pdf
    wkhtmltopdf --title "MuseScore 2.0 handbook" cover http://musescore.org/en/handbook-cover toc --xsl-style-sheet custom.xslt http://musescore.org/en/print/book/export/html/${NID}?pdf $PDFILE
    scp $PDFILE musescore@ftp.osuosl.org:~/data/handbook/MuseScore-2.0/
    ssh musescore@ftp.osuosl.org "~/trigger-musescore"
    rm $PDFILE
    ((INDEX++))
done
