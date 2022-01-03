# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="A VBA p-code disassembler"
HOMEPAGE="https://github.com/bontchev/pcodedmp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="GPL-3"
SLOT=0

RDEPEND=""
DEPEND="${RDEPEND}"
