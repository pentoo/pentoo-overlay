# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit git-r3 autotools eutils

DESCRIPTION="Power Line Communication device manager"
HOMEPAGE="https://github.com/ffainelli/faifa"
EGIT_REPO_URI="https://github.com/ffainelli/faifa.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND="dev-libs/libevent"
RDEPEND="${DEPEND}"

src_prepare() {
	#do no strip
	sed -i -e "s:installman strip:installman:" Makefile.in
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}
