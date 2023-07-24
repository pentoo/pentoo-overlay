# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 pypi

DESCRIPTION="Google Cloud Translation API"
HOMEPAGE="https://pypi.org/project/google-cloud-translate"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RESTRICT="test"

RDEPEND="dev-python/google-cloud-core[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

KEYWORDS="amd64 ~x86"

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
