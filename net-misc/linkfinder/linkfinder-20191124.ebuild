# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A python script that finds endpoints in JavaScript files"
HOMEPAGE="https://github.com/GerbenJavado/LinkFinder"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GerbenJavado/LinkFinder"
else
	# snapshot: 20191124
	HASH_COMMIT="7495676cfc84f5b5df1a2d7ffcf12a8b866de1a6"

	SRC_URI="https://github.com/GerbenJavado/LinkFinder/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/LinkFinder-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/jsbeautifier[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

pkg_setup() {
	python_setup
}

src_install() {
	distutils-r1_python_install
	python_foreach_impl python_newscript linkfinder.py linkfinder

	insinto /usr/share/${PN}/
	doins *.html

	dodoc README.md Dockerfile
}

pkg_postinst() {
	einfo "\nSee documentation: https://github.com/GerbenJavado/LinkFinder#examples\n"
}
