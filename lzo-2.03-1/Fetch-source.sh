#!/bin/bash

SRC=lzo-2.03.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.oberhumer.com/opensource/lzo/download/$SRC

