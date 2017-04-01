#!/bin/bash

SRC=dovecot-2.2.13.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=a3eb1c0b1822c4f2b0fe9247776baa71

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.dovecot.org/releases/2.2/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/dovecot/dovecot-2.2.13.tar.gz/a3eb1c0b1822c4f2b0fe9247776baa71/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/7.6/d/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.shuffahalquran.com/X-Files/y_slack-14.1-pkgs/server/--source/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files6.directadmin.com/services/customapache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://files24.directadmin.com/services/customapache/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.overlay.junc.org/fidonet/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distro.ibiblio.org/fatdog/source/700/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://dlc.everycity.com/ec-userland/source-archives/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://distfiles.alpinelinux.org/distfiles/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://bbgentoo.ilb.ru/distfiles/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
