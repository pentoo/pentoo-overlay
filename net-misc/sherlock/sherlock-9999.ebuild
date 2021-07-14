# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit eutils python-single-r1

DESCRIPTION="Find usernames across social networks"
HOMEPAGE="https://github.com/sherlock-project/sherlock"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sherlock-project/sherlock"
else
	# snapshot: 20200907
	COMMIT="bf2daa39ea26075f916e009a4b22566526c96c8a"

	SRC_URI="https://github.com/sherlock-project/sherlock/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~mips ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="MIT"
SLOT=0
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/beautifulsoup:4[${PYTHON_MULTI_USEDEP}]
		dev-python/certifi[${PYTHON_MULTI_USEDEP}]
		dev-python/chardet[${PYTHON_MULTI_USEDEP}]
		dev-python/colorama[${PYTHON_MULTI_USEDEP}]
		dev-python/idna[${PYTHON_MULTI_USEDEP}]
		dev-python/lxml[${PYTHON_MULTI_USEDEP}]
		dev-python/PySocks[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/requests-futures[${PYTHON_MULTI_USEDEP}]
		dev-python/soupsieve[${PYTHON_MULTI_USEDEP}]
		dev-python/torrequest[${PYTHON_MULTI_USEDEP}]
		dev-python/urllib3[${PYTHON_MULTI_USEDEP}]
		>=net-libs/stem-1.8.0[${PYTHON_MULTI_USEDEP}]
	')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	python_fix_shebang "${S}"

	if [[ ${PV} != *9999 ]]; then
		sed -e "s/__version__ = \"\(.*\)\"/__version__ = \"${PV}\"/" \
			-i sherlock/sherlock.py || die
	fi

	if ! use test; then
		rm -rf sherlock/tests || die
	fi
}

src_test() {
	"${EPYTHON}" -m unittest discover -v || die
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r *.py sherlock/*

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper ${PN} "${EPYTHON} /usr/share/${PN}/sherlock.py"

	dodoc *.md Dockerfile
}
