# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_P="PyKCS11-${PV}"

DESCRIPTION="A complete PKCS#11 wrapper for Python"
HOMEPAGE="https://github.com/LudovicRousseau/PyKCS11"
SRC_URI="https://github.com/LudovicRousseau/PyKCS11/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="examples"
RESTRICT="test"

DEPEND="
	dev-lang/swig
	dev-python/setuptools[${PYTHON_USEDEP}]
"

DOCS=( README.md )

distutils_enable_sphinx docs

python_install_all() {
	if use examples; then
		insinto "/usr/share/doc/${MY_P}/"
		doins -r samples
	fi

	distutils-r1_python_install_all
}
