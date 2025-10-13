# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="The Official Api Spec Language for Dropbox"
HOMEPAGE="
	https://www.dropbox.com/developers
	https://github.com/dropbox/stone
	https://pypi.org/project/stone/
"
SRC_URI="https://github.com/dropbox/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="
	>=dev-python/ply-3.4[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}"/${P}-python3_11.patch )

distutils_enable_tests pytest

python_prepare_all() {
	# Don't run tests via setup.py pytest
	sed -i -e "/'pytest-runner .*',/d" setup.py || die

	distutils-r1_python_prepare_all
}
