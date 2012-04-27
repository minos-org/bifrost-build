#!/bin/bash

SRC=openssl-0.9.8w.tar.gz
DST=/var/spool/src/$SRC

[ -s "$DST" ] || wget -O $DST http://www.openssl.org/source/$SRC
