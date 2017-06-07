#!/bin/bash
wget -nv http://utils.musescore.org.s3.amazonaws.com/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
tar -xJf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

fc-cache -f -v
