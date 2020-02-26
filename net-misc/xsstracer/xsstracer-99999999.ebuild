# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

DESCRIPTION="A small python script to check for Cross-Site Tracing (XST)"
HOMEPAGE="https://github.com/1N3/XSSTracer"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/1N3/XSSTracer"
else
	# snapshot: 20160123
	HASH_COMMIT="f2ed21a50d5ee09c5cd2303ea309c2a1e4a2f524"

	SRC_URI="https://github.com/1N3/XSSTracer/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
	S="${WORKDIR}/XSSTracer-${HASH_COMMIT}"
fi

LICENSE="Unlicense"
SLOT="0"

IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}"

src_install() {
	dodoc README.md xsstracer_exploit.js

	python_foreach_impl python_doscript ${PN}.py
	make_wrapper \
		"${PN}" \
		"python2 /usr/bin/${PN}.py"
}
