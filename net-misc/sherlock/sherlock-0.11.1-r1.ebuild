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
	# snapshot: 20200509
	HASH_COMMIT="0ba49808878b3efe24029639dfcac7f55a02c0d0"

	SRC_URI="https://github.com/sherlock-project/sherlock/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~mips ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT=0
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_MULTI_USEDEP}]
		dev-python/certifi[${PYTHON_MULTI_USEDEP}]
		dev-python/chardet[${PYTHON_MULTI_USEDEP}]
		>=dev-python/colorama-0.4.1[${PYTHON_MULTI_USEDEP}]
		dev-python/idna[${PYTHON_MULTI_USEDEP}]
		dev-python/lxml[${PYTHON_MULTI_USEDEP}]
		>=dev-python/PySocks-1.7.0[${PYTHON_MULTI_USEDEP}]
		>=dev-python/requests-2.22.0[${PYTHON_MULTI_USEDEP}]
		dev-python/requests-futures[${PYTHON_MULTI_USEDEP}]
		dev-python/soupsieve[${PYTHON_MULTI_USEDEP}]
		dev-python/torrequest[${PYTHON_MULTI_USEDEP}]
		dev-python/urllib3[${PYTHON_MULTI_USEDEP}]
		>=net-libs/stem-1.8.0[${PYTHON_MULTI_USEDEP}]
	')"

PATCHES=( "${FILESDIR}"/${P}_add_support_custom_data_json-r1.patch )

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
	doins -r *.py sherlock/* data_bad_site.json

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper ${PN} "${EPYTHON} /usr/share/${PN}/sherlock.py"
	make_wrapper ${PN}-get-sitelist "${EPYTHON} /usr/share/${PN}/site_list.py"

	dodoc *.md Dockerfile
}
