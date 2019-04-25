# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib eutils

# webapp
#WEBAPP_OPTIONAL=yes
#WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="Extract data from TCP/IP traffic"
HOMEPAGE="http://www.xplico.org"
SRC_URI="https://github.com/xplico/xplico/archive/v.${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+geoip mysql"
# webui"
SLOT="0"

DEPEND="net-libs/libpcap
	>=net-libs/nDPI-2.8"
RDEPEND="mysql? ( dev-db/mysql )
		media-sound/sox
		media-sound/lame
		dev-db/sqlite:3
		geoip? ( dev-libs/geoip )"

#	webui? ( dev-lang/php
#		virtual/httpd-cgi
#	)

#	cups? ( app-text/ghostscript-gpl ) "

S="${WORKDIR}/${PN}-v.${PV}"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-include.patch

	# fix CFLAGS
	sed -i "s|CFLAGS = -rdynamic|CFLAGS += -rdynamic|g" Makefile
#	sed -i "s|CFLAGS = -rdynamic|CFLAGS += -rdynamic|g" system/dema/Makefile

	sed -i '/json_object_private.h/d' manipulators/mwebymsg/analyse.c

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
#	webapp_src_preinst
#	mv xi "${D}"/${MY_HTDOCSDIR}/xplico
	DESTDIR="${D}" emake -j1 install
#	webapp_src_install
}
