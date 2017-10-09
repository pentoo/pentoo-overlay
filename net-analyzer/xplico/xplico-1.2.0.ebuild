# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib eutils webapp

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="Extract data from TCP/IP traffic"
HOMEPAGE="http://www.xplico.org"
#SRC_URI="mirror://sourceforge/$PN/$P.tgz"

SRC_URI="https://sourceforge.net/projects/xplico/files/Xplico%20versions/${PV}/${P}.tar.gz/download -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+geoip mysql"
SLOT="0"

DEPEND="net-libs/libpcap
	>=net-libs/nDPI-2.0"
RDEPEND="mysql? ( dev-db/mysql )
		media-sound/sox
		media-sound/lame
		dev-lang/php
		virtual/httpd-cgi
		dev-db/sqlite:3
		geoip? ( dev-libs/geoip ) "
#		cups? ( app-text/ghostscript-gpl ) "
#videosnarf
#		>=net-libs/libndpi-1.5.0

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-dont-strip.patch
	epatch "${FILESDIR}"/"${P}"-ndpi2.patch

	# TODO:
	# unbundle json-c and geoip

	# fix CFLAGS
	sed -i "s|CFLAGS = -rdynamic|CFLAGS += -rdynamic|g" Makefile
#	sed -i "s|CFLAGS = -rdynamic|CFLAGS += -rdynamic|g" system/dema/Makefile

#	if use geoip; then
#		sed -i -e "s|GEOIP_LIB =.*|GEOIP_LIB = /usr/$(get_libdir)/libGeoIP.a|g" Makefile
#		sed -i "s|GeoLiteCity.dat|/usr/share/GeoIP/GeoIP.dat|" common/geoiploc.c
#		sed -i "s|-lpthread|-lpthread -lGeoIP|g" manipulators/www/Makefile\
#		manipulators/mfbc/Makefile manipulators/mwmail/Makefile\
#		manipulators/mfile/Makefile
#	fi

	eapply_user
}

src_compile() {
	DISABLE_GEOIP=1 emake -j1
}

src_install() {
	webapp_src_preinst
#	mv xi "${D}"/${MY_HTDOCSDIR}/xplico
	DESTDIR="${D}" emake -j1 install
	webapp_src_install
}
