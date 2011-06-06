# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A remote security scanner"
HOMEPAGE="http://www.openvas.org/"
SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="cli qt webgui"

DEPEND=""

RDEPEND="net-analyzer/openvas-scanner:4
	cli?    ( net-analyzer/openvas-cli:4 )
	qt?     ( net-analyzer/openvas-gsd:4 )
	webgui? ( net-analyzer/openvas-gsa:4
		net-analyzer/openvas-manager:4 )
	!net-analyzer/openvas-client
	!net-analyzer/openvas-libnasl
	!net-analyzer/openvas-plugins"

pkg_postinst() {
	elog "1. Call 'openvas-nvt-sync' to download/update plugins"
	elog "2. Call 'openvas-mkcert' to generate server certificate"
	elog "3. Call 'openvas-adduser' to create a user"
	elog "4. Call 'openvasad -c 'add_user' -n <youname>  -r Admin' to create a user using openvas-administrator"
	elog "5. Call 'openvas-mkcert-client -n om -i' to generate a client certificate"
	elog "6. Run  '/etc/init.d/openvassd start' "
	elog "7. Run  'touch /var/lib/openvas/mgr/tasks.db' file"
	elog "8. Call 'openvasmd --rebuild' to create OpenVAS Manager database"
	elog "9. Run '/etc/init.d/openvas-gsa start' "
	elog "0. Go to 'https://localhost' "
}
