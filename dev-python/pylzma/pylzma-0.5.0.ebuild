# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="Platform independent python bindings for the LZMA compression library."
HOMEPAGE="https://www.joachim-bauch.de/projects/pylzma/"
SRC_URI="https://github.com/fancycode/${PN}/archive/v${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests setup.py

python_install_all() {
	dodoc -r doc/.
	distutils-r1_python_install_all
}
