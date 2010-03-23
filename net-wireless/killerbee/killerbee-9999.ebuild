# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit subversion distutils

DESCRIPTION="KillerBee is a framework and tool set for testing of ZigBee and IEEE 802.15.4 networks"
HOMEPAGE="http://killerbee.googlecode.com"
SRC_URI=""
ESVN_REPO_URI="http://killerbee.googlecode.com/svn/trunk/killerbee"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="speed doc"

DEPEND="doc? ( dev-python/epydoc )
	${RDEPEND}"
RDEPEND="dev-python/pycairo
	dev-python/pyusb
	dev-python/pycrypto
	dev-python/pygtk
	speed? ( x86? ( dev-python/psyco ) )"

src_prepare() {
	#speed/psyco should automatically be disabled on all arches besides x86
	if use speed; then if use !x86; then einfo "Psyco (speed) support only available for x86."; fi; fi
	#add psyco support here
}

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
