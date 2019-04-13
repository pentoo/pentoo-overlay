# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/ffuf/ffuf"

inherit golang-vcs-snapshot

DESCRIPTION="Fast web fuzzer written in Go"
HOMEPAGE="https://github.com/ffuf/ffuf"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ffuf/ffuf"
else
	SRC_URI="https://github.com/ffuf/ffuf/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

RDEPEND="!net-analyzer/ffuf-bin"
DEPEND="${RDEPEND}
	dev-lang/go"

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go install -v -work -x ${EGO_BUILD_FLAGS} "${EGO_PN}"
}

src_install() {
	dobin bin/${PN}
	dodoc src/"${EGO_PN}"/README.md
}

pkg_postinst() {
	elog "\nSee documentation: https://github.com/ffuf/ffuf#usage\n"
}
