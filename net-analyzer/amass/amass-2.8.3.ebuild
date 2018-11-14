# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"github.com/asaskevich/EventBus d46933a94f05c6657d7b923fcf5ac563ee37ec79"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver c68f22031e4222b95e684bf7c4f593ec42ad775a"
	"github.com/irfansharif/cfilter d07d951ff29d52840ca5e798a17e80db4de8c820"
	"github.com/miekg/dns b0dc93d2760ef438612a252a9e448d054d28b625"
	"github.com/fatih/color 2d684516a8861da43017284349b7e303e809ac21"
	"github.com/sensepost/maltegolocal 6d52c19f6de471736b63485a39cfe08d4a4ce253"

#	"golang.org/x/sync 1d60e4601c6fd243af51cc01ddf169918a5407ca github.com/golang/sync"
)

EGO_PN=github.com/OWASP/Amass

inherit golang-vcs-snapshot

EGIT_COMMIT="${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/caffix/amass"
LICENSE="Apache-2.0"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~arm64"

#extraced from go.mod
DEPEND=">=dev-lang/go-1.10
	>=dev-go/fetchbot-1.1.2
	>=dev-go/goquery-1.4.1
	>=dev-go/cascadia-1.0.0
	dev-go/robotstxt-go
	dev-go/go-crypto
	dev-go/go-net
	dev-go/go-sys
	>=dev-go/go-text-0.3.0
	>=dev-go/go-tools-0_pre20180817
"
RDEPEND="${DEPEND}"

src_prepare() {
	#https://github.com/OWASP/Amass/issues/52
	sed -i "s|caffix/amass|OWASP/Amass|g" src/github.com/OWASP/Amass/cmd/amass.netdomains/main.go
	eapply_user
}

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
	go install -v -work -x ${EGO_BUILD_FLAGS} ./...
}

src_install(){
	dobin bin/amass*
}
