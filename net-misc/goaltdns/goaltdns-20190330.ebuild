# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/subfinder/goaltdns"
EGO_VENDOR=( "github.com/bobesa/go-domain-util 1d708c0" )

inherit eutils golang-vcs-snapshot

DESCRIPTION="A permutation generation tool written in golang"
HOMEPAGE="https://github.com/subfinder/goaltdns"

HASH_COMMIT="2b3e8a30b8cf333be47885687ca92794d8f485fa"
SRC_URI="https://github.com/subfinder/goaltdns/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="MIT"
IUSE=""
SLOT=0

RDEPEND=""
DEPEND="
	dev-go/go-net:=
	dev-go/go-text:=
	dev-lang/go"

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
	dodoc \
		src/"${EGO_PN}"/{README.md,words*.txt}
}
