#!/bin/bash

SRCVER=hostapd-0.7.3
PKG=opt-$SRCVER-1 # with build version

# PKGDIR is set by 'pkg_build'. Usually "/var/lib/build/all/$PKG".
PKGDIR=${PKGDIR:-/var/lib/build/all/$PKG}
SRC=/var/spool/src/$SRCVER.tar.gz
[ -f /var/spool/src/$SRCVER.tar.bz2 ] && SRC=/var/spool/src/$SRCVER.tar.bz2
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
./Fetch-source.sh || exit $?
pkg_uninstall # Uninstall any dependencies used by Fetch-source.sh

#########
# Install dependencies:
# pkg_available dependency1-1 dependency2-1
# pkg_install dependency1-1 || exit 2
pkg_install openssl-0.9.8r-1 || exit 2
pkg_install libnl-1.1-1 || exit 2

#########
# Unpack sources into dir under /var/tmp/src
cd $(dirname $BUILDDIR); tar xf $SRC

#########
# Patch
cd $BUILDDIR
sed -i "s,/usr/local/,$DST/opt/hostapd/," hostapd/Makefile
# patch -p1 < $PKGDIR/mypatch.pat

#########
# Configure
#B-configure-1 --prefix=/opt/$PKG --localstatedir=/var || exit 1
#[ -f config.log ] && cp -p config.log /var/log/config/$PKG-config.log

#########
# Post configure patch
# patch -p0 < $PKGDIR/Makefile.pat

#########
# Compile
cd hostapd || exit 1
cp defconfig .config || exit 1
sed -i 's/#CONFIG_DRIVER_NL80211/CONFIG_DRIVER_NL80211/' .config
echo "LIBS += -static -lnl -lm" >> .config
echo "LIBS_c += -static" >> .config
CFLAGS="-Wall -Os -march=i586" V=1 make || exit 1

#########
# Install into dir under /var/tmp/install
rm -rf "$DST"
mkdir -p $DST/opt/hostapd/bin
make install
OPTDIR=$DST/opt/hostapd
mkdir -p $OPTDIR/etc/config.flags
mkdir -p $OPTDIR/rc.d
echo yes > $OPTDIR/etc/config.flags/hostapd
echo $PKG > $OPTDIR/pkgversion
cp -p $PKGDIR/rc $OPTDIR/rc.d/rc.hostapd
[ -f $PKGDIR/README ] && cp -p $PKGDIR/README $OPTDIR

cp -p $PKGDIR/hostapd.conf $OPTDIR/etc/hostapd.conf.sample

#########
# Check result
cd $DST || exit 1
# [ -f usr/bin/myprog ] || exit 1
# (ldd sbin/myprog|grep -qs "not a dynamic executable") || exit 1

#########
# Clean up
cd $DST || exit 1
# rm -rf usr/share usr/man
strip opt/hostapd/bin/*

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
