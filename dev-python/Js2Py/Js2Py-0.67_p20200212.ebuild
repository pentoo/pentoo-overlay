# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#https://github.com/PiotrDabkowski/Js2Py/issues/106
PYTHON_COMPAT=( python3_{9..10} )
HASH_COMMIT="11ae438295a4e109c424e51ffbc18f78952ad4d5"

inherit distutils-r1

DESCRIPTION="JavaScript to Python Translator & JavaScript interpreter"
HOMEPAGE="https://pypi.org/project/Js2Py/"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/PiotrDabkowski/Js2Py/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/tzlocal-1.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.10[${PYTHON_USEDEP}]
	>=dev-python/pyjsparser-2.5.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
