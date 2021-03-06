#!/bin/bash

SRCVER=iptables-1.4.21
PKG=$SRCVER-2 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.bz2
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
# pkg_install dependency1-1 || exit 1
pkg_install musl-1.1.8-1 || exit 2 
export CC=musl-gcc
pkg_install musl-kernel-headers-3.17.0-1 || exit 2
pkg_install musl-pkg-config-0.23-1 || exit 2

pkg_install musl-libnetfilter_conntrack-1.0.4-1 || exit 2
pkg_install musl-libnfnetlink-1.0.1-1 || exit 2
pkg_install musl-libmnl-1.0.3-1 || exit 2
pkg_install musl-libpcap-1.6.2-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
libtool_fix-1
patch -p1 < $PKGDIR/musl.pat || exit 1

#########
# Configure
LIBS="-lnetfilter_conntrack -lmnl -lnfnetlink" B-configure-3 --prefix=/usr --enable-libipq --enable-bpf-compiler || exit 1

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
make install DESTDIR=$DST # --with-install-prefix may be an alternative

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
(ldd usr/sbin/xtables-multi|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST
rm -rf usr/share usr/include usr/lib usr/libexec
[ -d usr/sbin ] && strip usr/sbin/*

#########
# Make package
cd $DST
tar czf /var/spool/pkg/$PKG.tar.gz .

#########
# Cleanup after a success
cd /var/lib/build
[ "$DEVEL" ] || rm -rf "$DST"
[ "$DEVEL" ] || rm -rf "$BUILDDIR"
pkg_uninstall
exit 0
