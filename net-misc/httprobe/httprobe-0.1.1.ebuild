# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/tomnomnom/httprobe"

inherit eutils golang-vcs-snapshot

DESCRIPTION="Take a list of domains and probe for working HTTP and HTTPS servers"
HOMEPAGE="https://github.com/tomnomnom/httprobe"
SRC_URI="https://github.com/tomnomnom/httprobe/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Unlicense"
IUSE=""
SLOT=0

RDEPEND=""
DEPEND=">=dev-lang/go-1.12"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" "${EGO_PN}" || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-s -w" "${EGO_PN}" || die

	dobin bin/${PN}
	dodoc src/"${EGO_PN}"/README.md
}
