# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_P="mXtract-${PV}"

inherit toolchain-funcs

DESCRIPTION="A memory extractor & analyzer"
HOMEPAGE="https://github.com/rek7/mXtract"
SRC_URI="https://github.com/rek7/mXtract/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE="MIT"
RESTRICT="mirror"
SLOT="0"
IUSE=""
RDEPEND=""

S="${WORKDIR}"/${MY_P}

src_compile() {
	$(tc-getCXX) -std=c++11 ${CFLAGS} src/main.cpp -o ${PN}
}

src_install() {
	dodoc README.md example_regexes.db
	dobin ${PN}
}

pkg_postinst() {
	elog "\nUsage:"
	elog "    mxtract -wm -wr -e -i -d=/tmp/output/ -r=/usr/share/doc/${P}/example_regexes.db\n"
}
