# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit python distutils

DESCRIPTION="sslstrip remove https and forwards http"
HOMEPAGE="http://www.thoughtcrime.org/software/sslstrip/"
SRC_URI="http://www.thoughtcrime.org/software/sslstrip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/python-2.5
		 >=dev-python/twisted-web-8.1.0"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/lib/"${PN}"
	insinto /usr/lib/"${PN}"
	doins sslstrip.py lock.ico
	dodir /usr/lib/${PN}/sslstrip
	insinto /usr/lib/${PN}/sslstrip
	doins sslstrip/*.py
	newsbin "${FILESDIR}"/sslstrip-r1 sslstrip
	dodoc README
}

pkg_postinst() {
	python_mod_optimize /usr/lib/sslstrip/sslstrip/
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/sslstrip/sslstrip/
}
