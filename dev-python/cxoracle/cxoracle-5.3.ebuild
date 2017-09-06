# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

MY_PN="cx_Oracle"
DESCRIPTION="Python extension module that allows access to Oracle Databases"
HOMEPAGE="http://www.python.net/crew/atuining/cx_Oracle/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test doc"

DEPEND=">=dev-db/oracle-instantclient-basic-10.1.0.2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	distutils-r1_src_install
	if use test;then
		docinto tests/
		dodoc test/*
	fi
	if use doc;then
		dodoc html/*
	fi
}
