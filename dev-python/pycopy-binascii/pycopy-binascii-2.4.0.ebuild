# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-r1

MY_P="${PN}-${PV}.post5"

DESCRIPTION="A part of standard library of the Pycopy project"
HOMEPAGE="https://github.com/pfalcon/pycopy-lib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~arm64 ~mips ~x86"
LICENSE="MIT"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	mv -v "${S}/${MY_P}" "${WORKDIR}/binascii" || die
}

pkg_setup() {
	python_setup
}

src_install() {
	python_foreach_impl python_domodule binascii
}
