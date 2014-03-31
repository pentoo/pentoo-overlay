# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit flag-o-matic eutils user

DESCRIPTION="A utility for information gathering or security auditing"
HOMEPAGE="http://www.unicornscan.org"
SRC_URI="http://www.unicornscan.org/releases/${P}-2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="geoip httpd mysql postgres"

DEPEND="net-libs/libpcap
		dev-libs/libdnet
		sys-devel/libtool
		geoip? ( dev-libs/geoip )
		mysql? ( dev-db/mysql )
		postgres? ( dev-db/postgresql-base:8.4 )"
RDEPEND="${DEPEND}
		httpd? ( dev-lang/php[apache2]
		 		  www-servers/apache )"

src_configure() {
		epatch "${FILESDIR}"/${P}-configure.patch
}

src_compile() {
		local myconf=""

		append-flags "-D_GNU_SOURCE"

		if use geoip ; then
				myconf="--with-geoip"
		else
				myconf="--without-geoip"
		fi

		if use mysql ; then
				myconf="$myconf --with-mysql"
		fi

		if use postgres ; then
				myconf="$myconf --with-pgsql"
		fi

		econf \
				--with-libdnet=/usr \
				--with-listen-user=unicornscan \
				"${myconf}" || die
		emake || die
}

pkg_setup() {
		enewgroup unicornscan
		enewuser unicornscan -1 -1 -1 unicornscan
}

src_install() {
		emake DESTDIR="${D}" install || die "Install failed"
}
