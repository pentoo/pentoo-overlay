# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )

inherit eutils python-single-r1

DESCRIPTION="Find usernames across social networks"
HOMEPAGE="https://github.com/sherlock-project/sherlock"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sherlock-project/sherlock"
else
	# snapshot: 20190825
	HASH_COMMIT="6914c308a36df42929b31d0ee20cdb8dc53a1dfa"

	SRC_URI="https://github.com/sherlock-project/sherlock/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT=0
#IUSE="test"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-futures[${PYTHON_USEDEP}]
	dev-python/soupsieve[${PYTHON_USEDEP}]
	dev-python/torrequest[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	net-libs/stem[${PYTHON_USEDEP}]"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}"/add_support_custom_data_json.patch

	if [[ ${PV} != *9999 ]]; then
		sed -e "s/__version__ = \"\(.*\)\"/__version__ = \"${PV}\"/" \
			-i sherlock.py || die
	fi

	default
}

src_test() {
	:
}

src_install() {
	insinto "/usr/share/${PN}"
	doins data.json *.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper ${PN} "python3 /usr/share/${PN}/sherlock.py"
	make_wrapper ${PN}-get-sitelist "python3 /usr/share/${PN}/site_list.py"

	dodoc *.md Dockerfile
}
