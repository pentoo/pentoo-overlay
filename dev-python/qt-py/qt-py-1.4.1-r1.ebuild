# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Minimal Python 2 & 3 shim around all Qt bindings"
HOMEPAGE="https://github.com/mottosso/Qt.py"

LICENSE="MIT"
SLOT="0"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mottosso/Qt.py.git"
else
	PYPI_NO_NORMALIZE=1
	PYPI_PN="Qt.py"
	inherit pypi

	KEYWORDS="amd64 ~arm64 ~x86"
	#SRC_URI="https://github.com/mottosso/Qt.py/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
	#S="${WORKDIR}"/Qt.py-"${PV}"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/pyqt5[${PYTHON_USEDEP}]"

python_prepare_all() {
	#do not install LICENSE into /usr
	sed -e '/data_files/d' -i setup.py || die
	distutils-r1_python_prepare_all
}
