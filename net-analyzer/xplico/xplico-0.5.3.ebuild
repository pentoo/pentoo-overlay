# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit multilib

DESCRIPTION="Extract data from TCP/IP traffic"
HOMEPAGE="http://www.xplico.org"
SRC_URI="mirror://sourceforge/$PN/$P.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="+geoip mysql"
DEPEND="net-libs/libpcap
		geoip? ( dev-libs/geoip )
		dev-db/sqlite:0"
RDEPEND="mysql? ( dev-db/mysql )"
src_prepare() {
	# fix CFLAGS
	sed -i "s|-g -ggdb -O0|$CFLAGS|g" Makefile
	sed -i "s|-g -ggdb|$CFLAGS|g" system/dema/Makefile
	if use geoip; then
		sed -i -e "s|GEOIP_LIB =.*|GEOIP_LIB = /usr/$(get_libdir)/libGeoIP.a|g" Makefile
		sed -i "s|GeoLiteCity.dat|/usr/share/GeoIP/GeoIP.dat|" common/geoiploc.c
	fi
}

src_compile() {
	emake -j1
}

src_install() {
	DESTDIR="${D}" emake -j1 install || die "install failed"
	#FIXME: Setup webroot for use with Webserver
}
