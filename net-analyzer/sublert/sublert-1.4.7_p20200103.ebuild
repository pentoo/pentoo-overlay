# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit eutils python-single-r1

DESCRIPTION="Monitor new subdomains deployed by specific organizations and issued TLS/SSL certificate"
HOMEPAGE="https://github.com/yassineaboukir/sublert"

HASH_COMMIT="b9b63d6eaa2e7602ce1f2bd1a4ccc432235684b4"
SRC_URI="https://github.com/yassineaboukir/sublert/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/dnspython[${PYTHON_USEDEP}]
		dev-python/tld[${PYTHON_USEDEP}]
		dev-python/termcolor[${PYTHON_USEDEP}]
	')"

PATCHES=( "${FILESDIR}"/${P}_pentoo.patch )

S="${WORKDIR}/sublert-${HASH_COMMIT}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default

	# cleanup
	rm -f setup.py

	if [[ ${PV} != *9999 ]]; then
		sed -e "s/version = \"\(.*\)\"/version = \"${PV}\"/" \
			-i sublert.py || die
	fi

	python_fix_shebang "${S}"
}

src_install() {
	insinto "/usr/share/${PN}"
	doins *.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper $PN \
		"${EPYTHON} /usr/share/${PN}/sublert.py"

	dodoc *.md
}
