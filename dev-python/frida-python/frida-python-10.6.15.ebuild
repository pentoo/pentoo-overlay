# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4} )
inherit distutils-r1

MY_PN="frida"

DESCRIPTION="Inject JavaScript to explore native apps"
HOMEPAGE="https://github.com/frida/frida"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_PN}-${PV}"

DEPEND=""
RDEPEND="dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
"
