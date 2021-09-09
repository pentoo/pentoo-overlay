# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit eutils python-single-r1

DESCRIPTION="Find people's social media profile using reverse image search"
HOMEPAGE="https://github.com/ThoughtfulDev/EagleEye"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ThoughtfulDev/EagleEye"
else
	HASH_COMMIT="3f0c0af85c93cf49992c608bb56022cc68b2a6b9"
	SRC_URI="https://github.com/ThoughtfulDev/EagleEye/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	# WIP: dep dev-python/requests-html depends on currently masked
	# dev-python/pyee which may be removed soon. I asked for it to remain in
	# the tree: https://bugs.gentoo.org/711808#c67
	#KEYWORDS="~amd64 ~x86"
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
		dev-python/beautifulsoup4[${PYTHON_MULTI_USEDEP}]
		dev-python/face_recognition[${PYTHON_MULTI_USEDEP}]
		dev-python/html5lib[${PYTHON_MULTI_USEDEP}]
		dev-python/requests-html[${PYTHON_MULTI_USEDEP}]
		dev-python/selenium[${PYTHON_MULTI_USEDEP}]
		dev-python/spry[${PYTHON_MULTI_USEDEP}]
		dev-python/termcolor[${PYTHON_MULTI_USEDEP}]
		dev-python/weasyprint[${PYTHON_MULTI_USEDEP}]
		media-libs/opencv[python,${PYTHON_MULTI_USEDEP}]
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
