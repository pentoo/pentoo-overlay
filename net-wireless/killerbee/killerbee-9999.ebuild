# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit subversion distutils

DESCRIPTION="KillerBee is a framework and tool set for testing of ZigBee and IEEE 802.15.4 networks"
HOMEPAGE="http://killerbee.googlecode.com"
SRC_URI=""
ESVN_REPO_URI="http://killerbee.googlecode.com/svn/trunk/killerbee"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/epydoc )
	${RDEPEND}"
RDEPEND="dev-python/pycairo
	dev-python/pyusb
	dev-python/pycrypto
	dev-python/pygtk"

src_compile() {
	if use doc; then
		mkdir pdf
		epydoc --pdf -o pdf killerbee/
	fi
	ewarn "I'm too lazy to make the docs ship, feel free to fix it."
}

src_install() {
	distutils_src_install
	if use doc; then
		 dodoc "${S}/pdf/*.tex"
	fi
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
