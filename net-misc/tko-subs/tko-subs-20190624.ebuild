# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/anshumanbh/tko-subs"
EGO_VENDOR=(
	"github.com/bgentry/heroku-go ee4032d"
	"github.com/gocarina/gocsv a5c9099"
	"github.com/golang/protobuf v1.1.0"
	"github.com/google/go-github v15.0.0"
	"github.com/google/go-querystring 53e6ce1"
	"github.com/mattn/go-runewidth v0.0.2"
	"github.com/miekg/dns v1.0.7"
	"github.com/olekukonko/tablewriter d4647c9"
	"github.com/pborman/uuid v1.1"
	"golang.org/x/oauth2 0f29369 github.com/golang/oauth2"
)

inherit eutils golang-vcs-snapshot

DESCRIPTION="A tool that can help detect and takeover subdomains with dead DNS records"
HOMEPAGE="https://github.com/anshumanbh/tko-subs"

HASH_COMMIT="3e23ed7fd1efaccf6fef7739234f2aadbdb0fdd0" # 20190623
SRC_URI="https://github.com/anshumanbh/tko-subs/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="MIT"
IUSE=""
SLOT=0

RDEPEND=""
DEPEND="
	dev-go/go-net:=
	dev-go/go-crypto:=
	dev-go/go-sys:=
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
		src/"${EGO_PN}"/{README.md,providers-data.csv,domains.txt}
}
