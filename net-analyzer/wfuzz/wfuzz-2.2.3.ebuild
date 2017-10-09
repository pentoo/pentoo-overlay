# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
#inherit python-single-r1 multilib
inherit distutils-r1 multilib

DESCRIPTION="Wfuzz is a tool designed for bruteforcing Web Applications"
HOMEPAGE="http://www.edge-security.com/wfuzz.php"
SRC_URI="https://github.com/xmendez/wfuzz/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pycurl[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]"
