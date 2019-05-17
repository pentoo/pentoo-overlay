# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python{3_6,3_7} )
inherit distutils-r1

DESCRIPTION="Frida CLI tools"
HOMEPAGE="https://github.com/frida/frida-tools"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/colorama-0.2.7[${PYTHON_USEDEP}]
	>=dev-python/frida-python-12.5.3[${PYTHON_USEDEP}]
	<=dev-python/frida-python-13.0.0[${PYTHON_USEDEP}]
	>=dev-python/prompt_toolkit-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.0.2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
