# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils python distutils versionator

MY_P=${P/\_p/\-}

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
SRC_URI="mirror://sourceforge/calpp/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-util/calpp-0.90
	>=x11-drivers/ati-drivers-10.2"
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}/cpyrit_calpp"
	distutils_src_compile
}

src_install() {
	cd "${S}/cpyrit_calpp"
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/cpyrit
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/cpyrit
}
