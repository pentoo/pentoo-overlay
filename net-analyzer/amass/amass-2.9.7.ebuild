# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"github.com/asaskevich/EventBus d46933a94f05c6657d7b923fcf5ac563ee37ec79"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver c68f22031e4222b95e684bf7c4f593ec42ad775a"
	"github.com/irfansharif/cfilter d07d951ff29d52840ca5e798a17e80db4de8c820"
	"github.com/miekg/dns b0dc93d2760ef438612a252a9e448d054d28b625"
	"github.com/fatih/color 2d684516a8861da43017284349b7e303e809ac21"
	"github.com/go-ini/ini f55231ca73a76c1d61eb05fe0d64a1ccebf93cba"

	"github.com/caffix/cloudflare-roundtripper 4c29d231c9cb6ed0381bd10db5502610a2f59df9"
	"github.com/cenkalti/backoff 62661b46c4093e2c1f38d943e663db1a29873e80"
	"github.com/cznic/mathutil 297441e035482346a960053c9ea29669b13e1025"
	"github.com/d4l3k/messagediff 29f32d820d112dbd66e58492a6ffb7cc3106312b"
	"github.com/dghubble/go-twitter 7ecc41c771b6fe11669159da651b6adf06ee60bf"
	"github.com/dghubble/sling 7458fd7fa70b9b22f53ffe4a632bd5ae11284a89"
	"github.com/dlclark/regexp2 487489b64fb796de2e55f4e8a4ad1e145f80e957"

	"github.com/google/go-querystring 44c6ddd0a2342c386950e880b658017258da92fc"
	"github.com/robertkrimen/otto 15f95af6e78dcd2030d8195a138bd88d4f403546"
	"gopkg.in/sourcemap.v1 6e83acea0053641eff084973fee085f0c193c61a github.com/go-sourcemap/sourcemap"

	"github.com/qasaur/gremgo fa23ada7c5da27801a4c57e83ca1df451139a2f0"
	"github.com/cayleygraph/cayley f3cae7f1e94149ced3d0a9b0c358359792495dd7"
	"github.com/boltdb/bolt fd01fc79c553a8e99d512a07e8e0c63d4a3ccfc5"
	"github.com/tylertreat/BoomFilters 611b3dbe80e85df3a0a10a43997d4d5784e86245"
	"github.com/gogo/protobuf ba06b47c162d49f2af050fb4c75bcbc86a159d5c"
)

EGO_PN=github.com/OWASP/Amass

inherit golang-vcs-snapshot

EGIT_COMMIT="${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/OWASP/Amass"
LICENSE="Apache-2.0"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

#extracted from go.mod
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
	dev-go/go-oauth2
	dev-go/uuid
"

#https://bugs.gentoo.org/673704
#	dev-go/gopkg-sourcemap

RDEPEND="${DEPEND}"

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
	go install -v -work -x ${EGO_BUILD_FLAGS} ./...
}

src_install(){
	dobin bin/amass*
}
