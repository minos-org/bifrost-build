#!/bin/bash

SRC=php-5.3.14.tar.bz2
DST=/var/spool/src/"${SRC}"
MD5=7caac4f71e2f21426c11ac153e538392

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://static.php.net/www.php.net/distributions/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://museum.php.net/php5/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://source.ipfire.org/source-2.x/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.yafi.ru/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
