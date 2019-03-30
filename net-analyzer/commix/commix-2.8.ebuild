# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV}-20190326"

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 multilib

DESCRIPTION="Automated All-in-One OS command injection and exploitation tool"
HOMEPAGE="https://github.com/commixproject/commix"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/commixproject/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"/"${PN}"-"${MY_PV}"

src_prepare() {
	python_fix_shebang .
	default
}

src_install(){
	insinto /usr/$(get_libdir)/${PN}
	doins -r *

	fperms +x /usr/$(get_libdir)/${PN}/${PN}.py
	dosym "${EPREFIX}"/usr/$(get_libdir)/${PN}/${PN}.py /usr/bin/${PN}

	python_optimize "${D}"usr/$(get_libdir)/${PN}
}
