# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DESCRIPTION="A simple CORS misconfiguration scanner"
HOMEPAGE="https://github.com/RUB-NDS/CORStest"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RUB-NDS/CORStest"
else
	# snapshot: 20190704
	HASH_COMMIT="d8ddce2425b100f309269d73e17583c0ce365d66"

	SRC_URI="https://github.com/RUB-NDS/CORStest/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
	S="${WORKDIR}/CORStest-${HASH_COMMIT}"
fi

LICENSE="GPL-2"
SLOT=0

IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]"

src_install() {
	insinto "/usr/share/${PN}"
	doins -r \
		tldlist.dat \
		*.cors \
		*.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper $PN \
		"python2 /usr/share/${PN}/corstest.py"

	dodoc *.md
}
