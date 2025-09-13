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

# no documentation, it uses deprecated Python libraries / API
IUSE="examples"

distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
