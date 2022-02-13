# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit eutils python-single-r1

DESCRIPTION="Find people's social media profile using reverse image search"
HOMEPAGE="https://github.com/ThoughtfulDev/EagleEye"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ThoughtfulDev/EagleEye"
else
	HASH_COMMIT="bcd580bd59cd92862a708b12d9d53f2fa5fb37e5"
	SRC_URI="https://github.com/ThoughtfulDev/EagleEye/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/EagleEye-${HASH_COMMIT}"
fi

LICENSE="WTFPL-2"
IUSE=""
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-libs/boost
	dev-libs/libffi
	$(python_gen_cond_dep '
		dev-python/termcolor[${PYTHON_USEDEP}]
		media-libs/opencv[python,${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
		dev-python/face_recognition[${PYTHON_USEDEP}]
		dev-python/weasyprint[${PYTHON_USEDEP}]
		dev-python/requests-html[${PYTHON_USEDEP}]

		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/html5lib[${PYTHON_USEDEP}]
		dev-python/spry[${PYTHON_USEDEP}]
	')
	www-apps/chromedriver-bin
	www-apps/geckodriver
	x11-libs/gtk+:3
"

src_install() {
	insinto "/usr/share/${PN}"
	doins -r grabber known report utils config.json eagle-eye.py face_recog.py

	python_optimize "${ED}/usr/share/${PN}"

	make_wrapper eagle-eye \
		"${EPYTHON} /usr/share/${PN}/eagle-eye.py" \
		"/usr/share/${PN}"

	dodoc README.md
}
