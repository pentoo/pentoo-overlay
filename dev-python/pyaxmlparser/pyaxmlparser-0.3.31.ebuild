# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Parser for Android XML file and get Application Name without using Androguard"
HOMEPAGE="https://github.com/appknox/pyaxmlparser"
SRC_URI="https://github.com/appknox/pyaxmlparser/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="examples"

RDEPEND="
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/click-6.7[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-0.24.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
