# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
MY_PN=${PN/-/.}
PYPI_PN=${MY_PN}
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="common routines for ruamel packages"
HOMEPAGE="https://pypi.org/project/ruamel.base/"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

python_install() {
	distutils-r1_python_install --single-version-externally-managed
}
