# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit eutils python-single-r1

DESCRIPTION="Fast CORS misconfiguration vulnerabilities scannerbeers"
HOMEPAGE="https://github.com/chenjj/CORScanner"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chenjj/CORScanner"
else
	# snapshot: 20190721
	HASH_COMMIT="a4894211115ad7f3a59fbd3e69b20575fd74e435"

	SRC_URI="https://github.com/chenjj/CORScanner/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~mips ~x86"
	S="${WORKDIR}/CORScanner-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT=0

IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/gevent[${PYTHON_MULTI_USEDEP}]
		dev-python/tldextract[${PYTHON_MULTI_USEDEP}]
		dev-python/argparse[${PYTHON_MULTI_USEDEP}]
		dev-python/colorama[${PYTHON_MULTI_USEDEP}]
	')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r common \
		origins.json \
		*domains.txt \
		*.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper "cors_scan" \
		"${EPYTHON} /usr/share/${PN}/cors_scan.py"

	dodoc *.md
}
