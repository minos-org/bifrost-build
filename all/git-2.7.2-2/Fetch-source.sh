#!/bin/bash

SRC=git-2.7.2.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=162ddc6c9b243899ad67ebd6b1c166b1

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" https://www.kernel.org/pub/software/scm/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.mirrorservice.org/pub/software/scm/git/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.riken.jp/Linux/kernel.org/software/scm/git/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
