# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1

DESCRIPTION="Extract password policy from a windows machine"
HOMEPAGE="https://github.com/Wh1t3Fox/polenum"
SRC_URI="https://github.com/Wh1t3Fox/polenum/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/impacket[${PYTHON_MULTI_USEDEP}]')"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	python_fix_shebang .
}

src_install() {
	newbin ${PN}.py ${PN}
	dodoc README.md
}
