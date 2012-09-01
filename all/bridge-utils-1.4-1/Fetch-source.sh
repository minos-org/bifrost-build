#!/bin/bash

SRC=bridge-utils-1.4.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://downloads.sourceforge.net/project/bridge/bridge/bridge-utils-1.4/$SRC
