# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils

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
		postgres? ( dev-db/libpq )"
RDEPEND="httpd? ( dev-lang/php 
				  www-servers/apache )"

pkg_setup() {
		if use httpd && ! built_with_use --missing true dev-lang/php apache2; then
				eerror "The httpd USE flag for this package enables dependecies"
				eerror "needed for the web based front end."
				eerror "For this reason, you have to merge dev-lang/php"
				eerror "with the apache2 USE flag enabled, or disable the httpd"
				eerror "USE flag for this package."
				die "Missing apache2 USE flag on dev-lang/php"
		fi
}

src_unpack() {
		unpack ${A}
		cd "${S}"
		epatch "${FILESDIR}/${P}-configure.patch"
}

src_compile() {
		local myconf=""
		
		append-flags "-D_GNU_SOURCE"
		
		if use geoip ; then
				myconf="--with-geoip"
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

pkg_preinst() {
		enewgroup unicornscan
		enewuser unicornscan -1 -1 -1 unicornscan
}

src_install() {
		emake -j1 DESTDIR="${D}" install || die "Install failed"
}
