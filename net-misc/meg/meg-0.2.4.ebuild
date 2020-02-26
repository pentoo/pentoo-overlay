# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/tomnomnom/meg"
EGO_VENDOR=( "github.com/tomnomnom/rawhttp f7ac0ba" )

inherit eutils golang-vcs-snapshot

DESCRIPTION="Fetch many paths for many hosts - without killing the hosts"
HOMEPAGE="https://github.com/tomnomnom/meg"

SRC_URI="https://github.com/tomnomnom/meg/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="MIT"
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

	insinto "/usr/share/${PN}"
	doins -r src/"${EGO_PN}"/lists

	dodoc src/"${EGO_PN}"/{README.mkd,CONTRIBUTING.mkd}
}
