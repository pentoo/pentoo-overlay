# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit python-r1

DESCRIPTION="Find Friend's Instagram, FB and Twitter Profiles using Image Recognition and Reverse Image Search"
HOMEPAGE="https://github.com/ThoughtfulDev/EagleEye"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ThoughtfulDev/EagleEye"
else
	HASH_COMMIT="3f0c0af85c93cf49992c608bb56022cc68b2a6b9"
	SRC_URI="https://github.com/ThoughtfulDev/EagleEye/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
#WIP
#	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/EagleEye-${HASH_COMMIT}"
fi

LICENSE="BSD-2"
IUSE=""
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	www-apps/geckodriver
	www-apps/chromedriver-bin
	x11-libs/gtk+:3
	dev-libs/boost
	virtual/libffi
	dev-python/termcolor[${PYTHON_USEDEP}]
	media-libs/opencv[python,${PYTHON_USEDEP}]
	dev-python/selenium[${PYTHON_USEDEP}]
	dev-python/face_recognition[${PYTHON_USEDEP}]
	dev-python/weasyprint[${PYTHON_USEDEP}]
	dev-python/requests-html[${PYTHON_USEDEP}]
	dev-python/beautifulsoup[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/spry[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

#src_install() {
#	dodoc README.md CHANGELOG
#	python_foreach_impl python_domodule Linux/lazagne
#	python_foreach_impl python_newscript Linux/laZagne.py lazagne
#}
