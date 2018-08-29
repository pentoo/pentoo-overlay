# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
EGO_PN=github.com/commixproject/${PN}

inherit python-single-r1 multilib

MY_PV="${PV}-20180713"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/commixproject/commix.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="v${MY_PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="A tool to test web-based applications to find bugs, errors or injection attacks."
HOMEPAGE="https://github.com/commixproject/commix"

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
	dosym $(get_libdir)/${PN}/${PN}.py ${PN}

	python_optimize "${D}"usr/$(get_libdir)/${PN}
}
