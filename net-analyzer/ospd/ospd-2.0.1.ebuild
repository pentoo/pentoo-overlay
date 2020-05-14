# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1

DESCRIPTION="Base class for scanner wrappers,communication protocol for GVM"
HOMEPAGE="https://www.greenbone.net/en/"
SRC_URI="https://github.com/greenbone/ospd/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE="docs"

RDEPEND="dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

#PATCHES=( "${FILESDIR}/"8f359bb07901a18609974d5f3e587b8fe8c36177.patch )

python_compile() {
	if use docs; then
		bash "${S}"/doc/generate || die
		HTML_DOCS=( "${S}"/doc/. )
	fi
	distutils-r1_python_compile
}
