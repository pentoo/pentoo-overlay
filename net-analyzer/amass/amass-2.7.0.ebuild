# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"github.com/asaskevich/EventBus d46933a94f05c6657d7b923fcf5ac563ee37ec79"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver 1108d6e66ccf2c8e68ab26b5f64e6c0a2ad00899"
	"github.com/irfansharif/cfilter d07d951ff29d52840ca5e798a17e80db4de8c820"

	"github.com/miekg/dns b0dc93d2760ef438612a252a9e448d054d28b625"
	"github.com/fatih/color 2d684516a8861da43017284349b7e303e809ac21"

	"golang.org/x/sync 1d60e4601c6fd243af51cc01ddf169918a5407ca github.com/golang/sync"
	"github.com/sensepost/maltegolocal 6d52c19f6de471736b63485a39cfe08d4a4ce253"
)

EGO_PN=github.com/OWASP/Amass

inherit golang-vcs-snapshot

EGIT_COMMIT="${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/caffix/amass"
LICENSE="GPL-3"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~arm64"

#extraced from go.mod
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
