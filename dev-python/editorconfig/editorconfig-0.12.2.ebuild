# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

MY_PN=EditorConfig
MY_P=${MY_PN}-${PV}

DESCRIPTION="EditorConfig File Locator and Interpreter for Python"
HOMEPAGE="https://pypi.python.org/pypi/EditorConfig"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}
