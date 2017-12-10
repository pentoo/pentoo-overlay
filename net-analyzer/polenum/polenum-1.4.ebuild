# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="Extract password policy from a windows machine"
HOMEPAGE="https://github.com/Wh1t3Fox/polenum"
SRC_URI="https://github.com/Wh1t3Fox/polenum/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GNU-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-python/impacket[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_install() {
	newbin ${PN}.py ${PN}
	python_fix_shebang "${ED}"usr/bin
}
