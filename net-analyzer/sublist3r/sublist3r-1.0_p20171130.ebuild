# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
#PYTHON_COMPAT=( python2_7 )
inherit python-r1 python-utils-r1 git-r3

DESCRIPTION="Enumerate subdomains of websites using OSINT"
HOMEPAGE="https://github.com/aboul3la/Sublist3r"
EGIT_REPO_URI="https://github.com/aboul3la/Sublist3r.git"
EGIT_COMMIT="832d544fa643928f7fd5a5a556a4bbe5624bbce0"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


RDEPEND="dev-python/argparse[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_prepare() {
	#make it a module
	sed -e 's|from subbrute|from sublist3r.subbrute|' -i sublist3r.py || die "sed failed"
	default
}

src_install() {
	python_moduleinto ${PN}
	python_foreach_impl python_domodule subbrute
	newbin sublist3r.py sublist3r
	dodoc README.md LICENSE
}
