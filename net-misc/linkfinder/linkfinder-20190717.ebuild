# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6}} )

inherit distutils-r1

DESCRIPTION="A python script that finds endpoints in JavaScript files"
HOMEPAGE="https://github.com/GerbenJavado/LinkFinder"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GerbenJavado/LinkFinder"
else
	# snapshot: 20190717
	HASH_COMMIT="ceb93552377903ff84708d27587d1ce6b08e2a43"

	SRC_URI="https://github.com/GerbenJavado/LinkFinder/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/LinkFinder-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/jsbeautifier[${PYTHON_USEDEP}]"

pkg_setup() {
	python_setup
}

src_install() {
	distutils-r1_python_install
	python_foreach_impl python_doscript linkfinder.py
}

pkg_postinst() {
	elog "\nSee documentation: https://github.com/GerbenJavado/LinkFinder#examples\n"
}
