# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit multilib webapp

DESCRIPTION="Extract data from TCP/IP traffic"
HOMEPAGE="http://www.xplico.org"
SRC_URI="mirror://sourceforge/$PN/$P.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE="+geoip"
DEPEND="net-libs/libpcap
		geoip? ( dev-libs/geoip )
		dev-db/sqlite:0
		"
RDEPEND="dev-db/mysql
		 virtual/php
		 virtual/httpd-cgi
		 dev-db/sqlite:0
		 geoip? ( dev-libs/geoip )"

src_prepare() {
	# fix CFLAGS
	sed -i "s|-g -ggdb -O0|$CFLAGS|g" Makefile
	sed -i "s|-g -ggdb|$CFLAGS|g" system/dema/Makefile
	if use geoip; then
		sed -i -e "s|GEOIP_LIB =.*|GEOIP_LIB = /usr/$(get_libdir)/libGeoIP.a|g" Makefile
		sed -i "s|GeoLiteCity.dat|/usr/share/GeoIP/GeoIP.dat|" common/geoiploc.c
		sed -i "s|-lpthread|-lpthread -lGeoIP|g" manipulators/www/Makefile\
		manipulators/mfbc/Makefile || die 'sed failed'
	fi
}

src_compile() {
	emake -j1
}

src_install() {
	webapp_src_preinst
	mv xi "${D}"/${MY_HTDOCSDIR}/xplico
	DESTDIR="${D}" emake -j1 install || die "install failed"
	webapp_src_install
}
