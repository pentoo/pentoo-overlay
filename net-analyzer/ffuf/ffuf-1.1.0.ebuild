# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/ffuf/ffuf"

inherit golang-vcs-snapshot

DESCRIPTION="Fast web fuzzer written in Go"
HOMEPAGE="https://github.com/ffuf/ffuf"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ffuf/ffuf"
else
	SRC_URI="https://github.com/ffuf/ffuf/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lang/go"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-w" "${EGO_PN}"
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-w" "${EGO_PN}"

	dobin bin/${PN}
	dodoc src/"${EGO_PN}"/README.md
}

pkg_postinst() {
	einfo "\nSee documentation: https://github.com/ffuf/ffuf#usage\n"
}
