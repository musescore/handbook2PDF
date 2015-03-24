ABSPATH=$(cd "$(dirname "$0")"; pwd)
echo $ABSPATH
cd $ABSPATH

wkhtmltopdf --title "MuseScore 2.0 handbook" cover http://musescore.org/en/handbook-cover toc --xsl-style-sheet custom.xslt http://musescore.org/en/print/book/export/html/36546?pdf  MuseScore-en.pdf

scp MuseScore-en.pdf musescore@ftp.osuosl.org:~/data/handbook/MuseScore-2.0/
ssh musescore@ftp.osuosl.org "~/trigger-musescore"
