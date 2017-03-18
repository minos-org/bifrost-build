#!/bin/bash

SRC=automake-1.11.1.tar.bz2
DST=/var/spool/src/$SRC
MD5=c2972c4d9b3e29c03d5f2af86249876f

[ -s "$DST" ] || wget -O $DST http://ftp.gnu.org/gnu/automake/$SRC \
              || wget -O $DST http://mirror.cogentco.com/pub/gnu/automake/$SRC \
              || wget -O $DST //ftp.riken.jp/GNU/gnu/automake/$SRC \
 || ../../wget-finder -O $DST $SRC:$MD5
