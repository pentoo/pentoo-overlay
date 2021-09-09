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
	# snapshot: 20200213
	HASH_COMMIT="f3a61fe7afa4abc0305c802e51c814c3d31d4b56"

	SRC_URI="https://github.com/sherlock-project/sherlock/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~mips ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT=0
#IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_MULTI_USEDEP}]
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
		>=net-libs/stem-1.7.0[${PYTHON_MULTI_USEDEP}]
	')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}"/add_support_custom_data_json.patch

	if [[ ${PV} != *9999 ]]; then
		sed -e "s/__version__ = \"\(.*\)\"/__version__ = \"${PV}\"/" \
			-i sherlock.py || die
	fi

	python_fix_shebang "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins data.json *.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper ${PN} "${EPYTHON} /usr/share/${PN}/sherlock.py"
	make_wrapper ${PN}-get-sitelist "${EPYTHON} /usr/share/${PN}/site_list.py"

	dodoc *.md Dockerfile
}
