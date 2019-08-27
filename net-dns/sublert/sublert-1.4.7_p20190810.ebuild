# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )

inherit eutils python-single-r1

DESCRIPTION="Monitor new subdomains deployed by specific organizations and issued TLS/SSL certificate"
HOMEPAGE="https://github.com/yassineaboukir/sublert"

COMMIT_HASH="f0814ada5a5fbfb430d4473277ddeac6b6778739"
SRC_URI="https://github.com/yassineaboukir/sublert/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/psycopg:2[${PYTHON_USEDEP}]
	dev-python/argparse[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/tld[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]"

S="${WORKDIR}/sublert-${COMMIT_HASH}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}"/${P}_pentoo.patch

	# cleanup
	rm -f setup.py

	if [[ ${PV} != *9999 ]]; then
		sed -e "s/version = \"\(.*\)\"/version = \"${PV}\"/" \
			-i sublert.py || die
	fi

	python_fix_shebang "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins *.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper $PN \
		"python3 /usr/share/${PN}/sublert.py"

	dodoc *.md
}
