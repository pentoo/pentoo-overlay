# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(

#"github.com/caffix/recon e2c3ea0ba9caf74eaa1643ab8642d1363997a147"
#	"github.com/PuerkitoBio/gocrawl 3c6275ae0143e4fa9ee522c2d4008d983a2fefaf"
#	"github.com/PuerkitoBio/goquery 61aa1975b1f7856927c526b0e0cd8c8b3a3030d0"
#	"github.com/likexian/whois-go 2a3082919f1b4c463346655d09826ae07a6c843f"
#	"github.com/likexian/whois-parser-go 34880469cbbedc02c20d2747e6082030a4b735b3"
#	"github.com/PuerkitoBio/purell 975f53781597ed779763b7b65566e74c4004d8de"
#	"github.com/PuerkitoBio/urlesc de5bf2ad457846296e2031421a34e2568e304e35"
#	"github.com/andybalholm/cascadia 901648c87902174f774fac311d7f176f8647bdaa"
#	"github.com/miekg/dns 906238edc6eb0ddface4a1923f6d41ef2a5ca59b"
#	"github.com/temoto/robotstxt 9e4646fa705336d5b2fa9dddfafbe0a1a965acd7"
#	"golang.org/x/net e0c57d8f86c17f0724497efcb3bc617e82834821 github.com/golang/net"
#	"golang.org/x/text 4a13a3860a6e13b9c8d09ceeb19f19a4b68c1a4e github.com/golang/text"
#	"github.com/gamexg/proxyclient 7cd0c09b92ae6ea8afba75772b1d1e4bd1aa37eb"
#	"github.com/fatih/color 507f6050b8568533fb3f5504de8e5205fa62a114"
#	"github.com/shadowsocks/shadowsocks-go 924943c5f5da423cc66747fdf0d6ca1052db200a"
#	"github.com/Yawning/chacha20 e3b1f968fc6397b51d963fee8ec8711a47bc0ce8"
	"github.com/asaskevich/EventBus d46933a94f05c6657d7b923fcf5ac563ee37ec79"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver 1108d6e66ccf2c8e68ab26b5f64e6c0a2ad00899"
	"github.com/irfansharif/cfilter d07d951ff29d52840ca5e798a17e80db4de8c820"

	"github.com/miekg/dns b0dc93d2760ef438612a252a9e448d054d28b625"
	"github.com/fatih/color 2d684516a8861da43017284349b7e303e809ac21"

	"golang.org/x/sync 1d60e4601c6fd243af51cc01ddf169918a5407ca github.com/golang/sync"
	"github.com/sensepost/maltegolocal 6d52c19f6de471736b63485a39cfe08d4a4ce253"
)

#"golang.org/x/sync/semaphore"
#	github.com/asaskevich/EventBus v0.0.0-20180315140547-d46933a94f05
#	github.com/johnnadratowski/golang-neo4j-bolt-driver v0.0.0-20180720234410-c68f22031e42
#	github.com/miekg/dns v1.0.8
#	github.com/temoto/robotstxt v0.0.0-20170603013557-9e4646fa7053 // indirect

EGO_PN=github.com/OWASP/Amass

#inherit golang-build golang-vcs-snapshot
inherit golang-vcs-snapshot

EGIT_COMMIT="v${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/caffix/amass"
LICENSE="GPL-3"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~arm64"

#fix me: gocrawl, goquery, purell cascadia, dns, text
DEPEND=">=dev-lang/go-1.10
	dev-go/fetchbot
	dev-go/goquery
	dev-go/cascadia
	dev-go/robotstxt-go
	dev-go/go-crypto
	dev-go/go-net
	dev-go/go-sys
	dev-go/go-text
	dev-go/go-tools
"
RDEPEND="${DEPEND}"


src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
	go install -v -work -x ${EGO_BUILD_FLAGS} ./...
}

src_install(){
	dobin bin/amass
}
