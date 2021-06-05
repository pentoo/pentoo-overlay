# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit eutils python-single-r1

DESCRIPTION="Discovery IP Address of the target"
HOMEPAGE="https://github.com/j3ssie/IPOsint"

HASH_COMMIT="6b8d1dbeebc19e70fc92418c1af26511362182cb" # 20190615
SRC_URI="https://github.com/j3ssie/IPOsint/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT=0
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/selenium-requests[${PYTHON_MULTI_USEDEP}]
		dev-python/lxml[${PYTHON_MULTI_USEDEP}]
		>=dev-python/beautifulsoup-4.6.3:4[${PYTHON_MULTI_USEDEP}]
		>=dev-python/pycryptodome-3.7.2[${PYTHON_MULTI_USEDEP}]
		dev-python/pyopenssl[${PYTHON_MULTI_USEDEP}]
		>=dev-python/urllib3-1.23[${PYTHON_MULTI_USEDEP}]
		dev-python/cryptography[${PYTHON_MULTI_USEDEP}]
	')
	www-apps/chromedriver-bin"

S="${WORKDIR}/IPOsint-${HASH_COMMIT}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}"/${P}_minor_changes.patch

	python_fix_shebang -q "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	for x in modules ip-osint.py; do
		doins -r "$x"
	done

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper "ip-osint" \
		"${EPYTHON} /usr/share/${PN}/ip-osint.py"

	dodoc README.md
}
