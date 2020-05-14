# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

MY_PN="openvas"

DESCRIPTION="Open Vulnerability Assessment Scanner"
HOMEPAGE="https://www.greenbone.net/en/"
SRC_URI="https://github.com/greenbone/openvas/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 GPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-crypt/gpgme:=
	dev-db/redis
	dev-libs/libgcrypt:=
	dev-libs/libksba
	>=net-analyzer/gvm-libs-11.0.0
	net-analyzer/net-snmp
	net-libs/gnutls:=
	net-libs/libpcap
	net-libs/libssh:="

RDEPEND="${DEPEND}
	!net-analyzer/openvas
	!net-analyzer/openvas-tools"

BDEPEND="sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=${EPREFIX}/usr"
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
	)
	# Add release hardening flags for 6.0.1
#	append-cflags -Wno-format-truncation -Wformat -Wformat-security -D_FORTIFY_SOURCE=2 -fstack-protector
#	append-ldflags -Wl,-z,relro -Wl,-z,now
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dodir /etc/${MY_PN}
	insinto /etc/${MY_PN}
	doins "${FILESDIR}/${MY_PN}.conf"
}
