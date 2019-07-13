# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/haccer/subjack"
EGO_VENDOR=(
	"github.com/haccer/available 1.0.1"
	"github.com/miekg/dns v1.1.15"
	"github.com/valyala/fasthttp v1.4.0"
	"github.com/valyala/bytebufferpool v1.0.0"
	"github.com/domainr/whois 975c783"
	"github.com/klauspost/compress v1.7.2"
	"github.com/klauspost/cpuid v1.2.1"
	"github.com/saintfish/chardet 3af4cd4"
	"github.com/zonedb/zonedb v1.0.2361"
)

inherit eutils golang-vcs-snapshot

DESCRIPTION="Subdomain Takeover tool written in Go"
HOMEPAGE="https://github.com/haccer/subjack"

SRC_URI="https://github.com/haccer/subjack/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="MIT"
IUSE=""
SLOT=0

RDEPEND=""
DEPEND="
	dev-go/go-net:=
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
		src/"${EGO_PN}"/README.md
}
