# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYPI_PN="PyDispatcher"
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Multi-producer-multi-consumer signal dispatching mechanism"
HOMEPAGE="http://pydispatcher.sourceforge.net/ https://pypi.org/project/PyDispatcher/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="doc examples"

RDEPEND=""
DEPEND="${RDEPEND}"

python_compile_all() {
	if use doc; then
		pushd docs/pydoc/ > /dev/null
		"${PYTHON}" builddocs.py || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

python_test() {
	"${PYTHON}" -m unittest discover
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/pydoc/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
