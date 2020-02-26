# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
#python3_{5,6} )
inherit distutils-r1

DESCRIPTION="Cuckoo Sandbox Shellcode Identification & Formatting"
HOMEPAGE="https://cuckoosandbox.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-libs/capstone[python,${PYTHON_USEDEP}]
	!!dev-libs/capstone-bindings"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
