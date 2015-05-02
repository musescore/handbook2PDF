#!/bin/bash

# move to current directory
ABSPATH=$(cd "$(dirname "$0")"; pwd)
echo $ABSPATH
cd $ABSPATH

WKHTML=/usr/local/bin/wkhtmltopdf

#list of languages and nodes
LANGUAGES=( en de ja )
NIDS=( 36546 55116 55261 )

LANGUAGE_COUNT=${#LANGUAGES[@]}
INDEX=0

while [ "$INDEX" -lt "$LANGUAGE_COUNT" ]
do
    LANGUAGE=${LANGUAGES[$INDEX]}
    NID=${NIDS[$INDEX]}
    echo "update handbook $LANGUAGE"
    PDFILE=MuseScore-${LANGUAGE}.pdf
    $WKHTML --footer-center '[page]' --footer-spacing 2 --title "MuseScore 2.0 handbook" cover https://musescore.org/${LANGUAGE}/handbook-cover toc --xsl-style-sheet custom.xslt https://musescore.org/${LANGUAGE}/print/book/export/html/${NID}?pdf $PDFILE > /dev/null 2>&1
    scp $PDFILE musescore@ftp.osuosl.org:~/data/handbook/MuseScore-2.0/
    ssh musescore@ftp.osuosl.org "~/trigger-musescore"
    rm $PDFILE
    ((INDEX++))
done
