#!/bin/bash

SRC=sshfs-fuse-2.4.tar.gz
DST=/var/spool/src/"${SRC}"
MD5=3c7c3647c52ce84d09486f1da3a3ce24

[ -s "${DST}" ] || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://downloads.sourceforge.net/project/fuse/sshfs-fuse/2.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://pkgs.fedoraproject.org/repo/pkgs/fuse-sshfs/sshfs-fuse-2.4.tar.gz/3c7c3647c52ce84d09486f1da3a3ce24/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://alien.slackbook.org/slackbuilds/sshfs-fuse/build/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://rlworkman.net/pkgs/sources/13.37/sshfs-fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://repository.timesys.com/buildsources/s/sshfs-fuse/sshfs-fuse-2.4/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://www.slackware.com/~alien/slackbuilds/sshfs-fuse/build/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.chmuri.net/salix/arm/14.0/source/n/sshfs-fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://sources.openelec.tv/mirror/sshfs-fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.mirrorservice.org/sites/download.salixos.org/x86_64/14.1/source/n/sshfs-fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://salix.enialis.net/arm/14.0/source/n/sshfs-fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp.lfs-matrix.net/pub/blfs/conglomeration/sshfs/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirror.bjtu.edu.cn/salix/arm/14.0/source/n/sshfs-fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://mirrors.nix.org.ua/linux/salixos/i486/14.0/source/n/sshfs-fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://slackware.uk/salix/i486/14.0/source/n/sshfs-fuse/"${SRC}" \
                || ../../wget-finder --checksum "${MD5}" -O "${DST}" http://ftp1.fr.freebsd.org/pub/frugalware/frugalware-stable/source/apps-extra/sshfs-fuse/"${SRC}" \
                || ../../wget-finder -O "${DST}" "${SRC}:${MD5}"
