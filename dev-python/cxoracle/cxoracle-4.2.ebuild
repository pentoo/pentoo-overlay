# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit distutils

MY_P="cx_Oracle-${PV}"
DESCRIPTION="Python extension module that allows access to Oracle Databases"
HOMEPAGE="http://www.python.net/crew/atuining/cx_Oracle/"
SRC_URI="mirror://sourceforge/$PN/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test doc"

DEPEND=">=dev-lang/python-2.2.2
>=dev-db/oracle-instantclient-basic-10.1.0.2"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	if use test;then
		docinto tests/
		dodoc test/*
	fi
	if use doc;then
		dodoc html/*
	fi
}

pkg_postinst() {
	einfo
	einfo "Getting started with cx_Oracle:"
	einfo "http://www.oracle.com/technology/pub/articles/devlin-python-oracle.html"
	einfo
}
