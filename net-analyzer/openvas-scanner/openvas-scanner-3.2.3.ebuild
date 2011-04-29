# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-scanner)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/862/${P}.tar.gz"
SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="restricted"

RDEPEND="app-crypt/gpgme
	>=dev-libs/glib-2
	net-libs/gnutls
	net-libs/libpcap
	net-analyzer/openvas-libraries:4[restricted]"
DEPEND="${RDEPEND}"

CMAKE_BUILD_DIR="${S}"

src_configure() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc -DOPENVAS_PID_DIR=/var/run/openvas/)
	cmake-utils_src_configure || die
}

#TODO dont respect CFLAGS
src_compile() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc -DOPENVAS_PID_DIR=/var/run/openvas/)
	cmake-utils_src_compile  || die
}

src_install() {
	cmake-utils_src_install || die
	insinto /etc/openvas
	doins "${FILESDIR}"/openvassd.conf || die
	dodoc README ChangeLog || die
	doinitd "${FILESDIR}"/openvassd || die
	newconfd "${FILESDIR}"/openvassd.confd openvassd || die
	if use restricted ; then
		fowners root:openvas /etc/openvas/openvassd.conf || die
		sed -i 's/root/openvas/' "${D}"/etc/conf.d/openvassd || die
	fi
}

pkg_postinst() {
	einfo "1. Call 'openvas-nvt-sync' to download/update plugins"
	einfo "2. Call 'openvas-mkcert' to generate server certificate"
	einfo "3. Call 'openvas-adduser' to create a user"
}
