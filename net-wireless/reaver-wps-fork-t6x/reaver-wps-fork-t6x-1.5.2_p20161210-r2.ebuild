# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_IN_SOURCE_BUILD="1"
inherit autotools-utils eutils git-r3

DESCRIPTION="Utilise Pixie Dust Attack to find the correct WPS PIN."
HOMEPAGE="https://github.com/t6x/reaver-wps-fork-t6x"
EGIT_REPO_URI="https://github.com/t6x/reaver-wps-fork-t6x.git"
EGIT_COMMIT="c94ce484c4f6d9fb3bd3657cc6dc07eabb927dcd"

ECONF_SOURCE="${S}/src"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!net-wireless/reaver
	net-libs/libpcap
	dev-db/sqlite:3"
RDEPEND="${DEPEND}"

ECONF_SOURCE="${S}/src"

#these patches need to be verified and pushed to upstream
src_prepare() {
	#https://github.com/pentoo/pentoo-overlay/issues/139
	epatch "${FILESDIR}"/0006-announce-fcs.patch
}

src_install() {
	cd src
	dobin wash reaver

	insinto "/etc/reaver"
	doins reaver.db

	doman ../docs/reaver.1.gz
	dodoc ../docs/README ../docs/README.REAVER ../docs/README.WASH
}
