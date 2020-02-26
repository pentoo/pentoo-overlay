# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Frida CLI tools"
HOMEPAGE="https://github.com/frida/frida-tools"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/colorama[${PYTHON_USEDEP}]
	>=dev-python/frida-python-12.8.5[${PYTHON_USEDEP}]
	>=dev-python/prompt_toolkit-2.0.0[${PYTHON_USEDEP}] <dev-python/prompt_toolkit-3.0.0
	>=dev-python/pygments-2.0.2[${PYTHON_USEDEP}]"
