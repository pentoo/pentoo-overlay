# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils

DESCRIPTION="Power Line Communication device manager"
HOMEPAGE="https://github.com/ffainelli/faifa"
SRC_URI="https://github.com/ffainelli/faifa/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}"_symlink.patch
	#do no strip
	sed -i -e "s:installman strip:installman:" Makefile.in
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}
