# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils flag-o-matic

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="https://github.com/greenbone/gvm-libs/releases/download/v${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="ldap"

RDEPEND="
	app-crypt/gpgme
	>=dev-libs/glib-2.32
	>=dev-libs/hiredis-0.10.1
	dev-libs/libgcrypt:0
	dev-libs/libksba
	!net-analyzer/openvas-libnasl
	net-libs/gnutls[tools]
	net-libs/libpcap
	>=net-libs/libssh-0.5.0
	net-analyzer/net-snmp
	ldap? (	net-nds/openldap )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	"

S="${WORKDIR}/gvm-libs-${PV}"

DOCS=( ChangeLog CHANGES README )

src_prepare() {
	sed \
		-e '/^install.*OPENVAS_CACHE_DIR.*/d' \
		-i CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	append-cppflags -U_FORTIFY_SOURCE
	local mycmakeargs=(
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
		"-DOPENVAS_PID_DIR=/run"
		$(usex ldap -DBUILD_WITHOUT_LDAP=0 -DBUILD_WITHOUT_LDAP=1)
	)
	cmake-utils_src_configure
}

src_install() {
	keepdir /var/lib/openvas/gnupg
	keepdir /var/log/openvas
	cmake-utils_src_install
}
