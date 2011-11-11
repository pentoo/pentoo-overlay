# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/smudge/smudge-0.8.ebuild,v 1.1.1.1 2006/03/13 21:06:24 grimmlin Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Smudge is basically a port of SPIKE into python scripts"
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI="http://dev.pentoo.ch/~grimmlin/distfiles/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

PYTHON_MODNAME="SMUDGE"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	# also install smudge as a importable python module
	insinto /usr/$(get_libdir)/python$(python_get_version)/site-packages/
	doins *.py

	insinto /opt/smudge/
	dodir /opt/smudge/logs/
	insopts -m0755
	doins *.py
	insopts -m0644
	insinto /opt/smudge/misc
	doins -r misc/*
	dosbin "${FILESDIR}"/${PN}
	dodoc COPYING.txt CHANGELOG.txt README.txt
	}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
