# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/rverton/webanalyze"
EGO_VENDOR=( "github.com/bobesa/go-domain-util 1d708c0" )

inherit eutils golang-vcs-snapshot

DESCRIPTION="Port of Wappalyzer (uncovers technologies used on websites) in Go to automate scanning"
HOMEPAGE="https://github.com/rverton/webanalyze"

HASH_COMMIT="ab86050f17f1c3ddd70af3164cb1f56f405d2d38"
SRC_URI="https://github.com/rverton/webanalyze/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="GPL-3"
IUSE=""
SLOT=0

RDEPEND=""
DEPEND="
	dev-go/go-net:=
	dev-go/go-text:=
	>=dev-lang/go-1.12"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" "${EGO_PN}"/cmd/webanalyze/ || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-s -w" "${EGO_PN}"/cmd/webanalyze/ || die

	newbin bin/webanalyze ${PN}
	dodoc \
		src/"${EGO_PN}"/README.md
}
