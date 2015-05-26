#!/bin/bash

# move to current directory
ABSPATH=$(cd "$(dirname "$0")"; pwd)
echo $ABSPATH
cd $ABSPATH

WKHTML=/usr/local/bin/wkhtmltopdf

LANGUAGES=( en af de ar be bg ca cs da et el es eo fa eu fr gl ko sr hr id it he lt hu nl ja nb pl pt-br pt-pt ro ru sk sl fi sv vi tr uk zh-hans zh-hant )
NIDS=( 36546 55111 55116 55146 55151 55156 55161 55166 55171 55176 55181 55186 55191 55196 55201 55206 55211 55216 55221 55226 55231 55236 55241 55246 55251 55256 55261 55266 55271 55276 55281 55286 55291 55296 55301 55306 55311 55316 55321 55326 55331 55336 )

LANGUAGE_COUNT=${#LANGUAGES[@]}
INDEX=0

while [ "$INDEX" -lt "$LANGUAGE_COUNT" ]
do
    LANGUAGE=${LANGUAGES[$INDEX]}
    NID=${NIDS[$INDEX]}
    echo "update handbook $LANGUAGE"
    PDFILE=MuseScore-${LANGUAGE}.pdf
    $WKHTML --footer-center '[page]' --footer-spacing 2 --title "MuseScore 2.0 handbook" cover https://musescore.org/${LANGUAGE}/handbook-cover toc --xsl-style-sheet custom.xslt https://musescore.org/${LANGUAGE}/print/book/export/html/${NID}?pdf $PDFILE > /dev/null 2>&1
    #scp $PDFILE musescore@ftp.osuosl.org:~/data/handbook/MuseScore-2.0/
    #ssh musescore@ftp.osuosl.org "~/trigger-musescore"
    #rm $PDFILE
    ((INDEX++))
done
