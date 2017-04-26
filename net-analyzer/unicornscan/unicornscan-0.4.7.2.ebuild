# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit flag-o-matic eutils user versionator
MY_PV=$(replace_version_separator 3 '-' )

DESCRIPTION="A utility for information gathering or security auditing"
HOMEPAGE="http://www.unicornscan.org"
#SRC_URI="http://www.unicornscan.org/releases/${PN}-${MY_PV}.tar.bz2"
SRC_URI="https://github.com/IFGHou/Unicornscan/archive/${PN}-${MY_PV}.tar.gz -> ${P}.tar.gz"

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

S="${WORKDIR}/Unicornscan-${PN}-${MY_PV}"

src_configure() {
	epatch "${FILESDIR}"/${PN}-0.4.7-configure.patch
	epatch "${FILESDIR}"/${PN}-0.4.7-gcc5.patch
	epatch "${FILESDIR}"/${PN}-0.4.7-geoip.patch

	local myconf=""

	append-cppflags "-D_GNU_SOURCE"

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
}

src_compile() {
	emake
}

pkg_setup() {
	enewgroup unicornscan
	enewuser unicornscan -1 -1 -1 unicornscan
}

src_install() {
	emake DESTDIR="${D}" install
}
