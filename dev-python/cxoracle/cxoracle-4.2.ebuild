# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_P="cx_Oracle-${PV}"
DESCRIPTION="Python extension module that allows access to Oracle Databases"
HOMEPAGE="http://www.python.net/crew/atuining/cx_Oracle/"
SRC_URI="http://easynews.dl.sourceforge.net/sourceforge/cx-oracle/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="Computronix"
SLOT="0"
KEYWORDS="~ia64 ~ppc ~x86"
IUSE="tests docs"

DEPEND=">=dev-lang/python-2.2.2
>=dev-db/oracle-instantclient-basic-10.1.0.2"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_P}"

src_compile() {
	cd "${S}"
	distutils_src_compile
}

src_install() {
	cd "${S}"
	distutils_src_install
	if use "tests";then
		docinto tests/
		dodoc test/*
	fi
	if use "docs";then
		dodoc html/*
	fi
}

pkg_postinst() {
	einfo
	einfo "Getting started with cx_Oracle:"
	einfo "http://www.oracle.com/technology/pub/articles/devlin-python-oracle.html"
	einfo
}
