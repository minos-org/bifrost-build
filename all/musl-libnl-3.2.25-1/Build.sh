#!/bin/bash

SRCVER=libnl-3.2.25
PKG=musl-$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
BUILDDIR=/var/tmp/src/$SRCVER
DST="/var/tmp/install/$PKG"

#########
# Simple inplace edit with sed.
# Usage: sedit 's/find/replace/g' Filename
function sedit {
    sed "$1" $2 > /tmp/sedit.$$
    cp /tmp/sedit.$$ $2
    rm /tmp/sedit.$$
}

#########
# Fetch sources
./Fetch-source.sh || exit 1
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
pkg_install bison-2.4.2-1 || exit 2
pkg_install m4-1.4.14-1 || exit 2
pkg_install flex-2.5.35-1 || exit 2
pkg_install musl-1.1.3-1 || exit 2 
pkg_install musl-kernel-headers-3.17.0-1 || exit 2
export CC=musl-gcc

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
# patch -p1 < $PKGDIR/mypatch.pat
sed -i 's,<sys/poll.h>,<poll.h>,' include/netlink/netlink.h
sed -i 's/__bswap_64/bswap_64/' lib/netfilter/ct.c
sed -i 's/__bswap_64/bswap_64/' lib/netfilter/log_msg.c
sed -i 's/__bswap_64/bswap_64/' lib/netfilter/queue_msg.c

patch -p0 < $PKGDIR/bswap.pat || exit 1

#########
# Configure
B-configure-1 --prefix=/opt/musl || exit 1
[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
patch -p1 < $PKGDIR/static.pat

#########
# Compile
make V=1 || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
rm -rf usr/share usr/sbin

#########
# Make package
cd $DST || exit 1
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
