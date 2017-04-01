#!/bin/bash

SRC=netperf-2.4.5.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=5cfaae1d024551161b8eafbd48faedf4

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" ftp://ftp.netperf.org/netperf/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.sunet.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/download/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.acc.umu.se/mirror/archive/ftp.sunet.se/pub/Linux/distributions/bifrost/old/src/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dev.gateworks.com/sources/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://de1.opensde.net/opensde/mirror/trunk/n/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
