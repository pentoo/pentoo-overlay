# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A VBA p-code disassembler"
HOMEPAGE="https://github.com/bontchev/pcodedmp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="GPL-3"
SLOT=0

RDEPEND=""
DEPEND="${RDEPEND}"
