# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A remote security scanner for Linux (openvas-scanner)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/724/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="tcpd gtk debug prelude"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	gtk? ( =x11-libs/gtk+-2* )
	prelude? ( dev-libs/libprelude )
	>=net-analyzer/openvas-libraries-3.0.5
	!net-analyzer/openvas-plugins
	!net-analyzer/openvas-server"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable tcpd tcpwrappers) \
		$(use_enable debug) \
		$(use_enable gtk) \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	dodoc CHANGES || die
	dodoc doc/*.txt || die

	doinitd "${FILESDIR}"/openvasd || die "doinitd failed"
	keepdir /var/lib/openvas/logs
	keepdir /var/lib/openvas/users
}

pkg_postinst() {
        ewarn "1. Call 'openvas-nvt-sync' to download plugins"
        ewarn "2. Call 'openvas-mkcert' to generate server certificate"
        ewarn "3. Call 'openvas-adduser' to create a user"
}

