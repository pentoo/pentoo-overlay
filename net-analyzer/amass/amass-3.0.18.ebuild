# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(

	"github.com/boltdb/bolt v1.3.1"
	"github.com/caffix/cloudflare-roundtripper 4c29d231c9cb6ed0381bd10db5502610a2f59df9"
	"github.com/cayleygraph/cayley v0.7.5"
	"github.com/cenkalti/backoff v2.1.1" #indirect
	"github.com/dghubble/go-twitter 53f972dc4b06"
	"github.com/dghubble/sling v1.2.0"
	"github.com/fatih/color v1.7.0"
	"github.com/geziyor/geziyor 71683ec6de71"

	"github.com/go-ini/ini v1.42.0"
	"github.com/gogo/protobuf v1.2.1"
	"github.com/google/go-querystring v1.0.0" #indirect

	"github.com/gorilla/websocket v1.4.0" #indirect
	"github.com/irfansharif/cfilter v0.1.1"
	"github.com/jmoiron/sqlx v1.2.0"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver 6b24c0085aae"
	"github.com/lib/pq v1.1.1"
	"github.com/mattn/go-colorable v0.1.2" #indirect
	"github.com/miekg/dns v1.1.14"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/qasaur/gremgo fa23ada7c5da27801a4c57e83ca1df451139a2f0"
	"github.com/robertkrimen/otto 15f95af6e78dcd2030d8195a138bd88d4f403546" # indirect
	"github.com/satori/go.uuid v1.2.0"

	"github.com/tylertreat/BoomFilters 611b3dbe80e8"

	"gopkg.in/sourcemap.v1 v1.0.5 github.com/go-sourcemap/sourcemap" #indirect

	"github.com/chromedp/chromedp v0.3.1"
	"github.com/chromedp/cdproto 1aa4f57ff2a9"
	"github.com/gobwas/httphead 2c6c146eadee" # indirect
	"github.com/gobwas/pool v0.2.0" # indirect
	"github.com/gobwas/ws v1.0.0"
	"github.com/mailru/easyjson 1ea4449da983"
	"github.com/knq/sysutil f05b59f0f307"

	"github.com/VividCortex/gohistogram v1.0.0" # indirect
	"github.com/fortytw2/leaktest v1.3.0"
	"github.com/fpfeng/httpcache 6b8f16a92be3"
	"github.com/go-kit/kit v0.8.0"
	"github.com/pkg/errors v0.8.1"
	"github.com/prometheus/client_golang v1.0.0"
	"github.com/stretchr/testify v1.3.0"

	"github.com/beorn7/perks v1.0.0"
	"github.com/golang/protobuf v1.3.1"
	"github.com/json-iterator/go v1.1.6"
	"github.com/modern-go/concurrent bacd9c7ef1dd" # indirect
	"github.com/modern-go/reflect2 v1.0.1" #// indirect
	"github.com/prometheus/client_model fd36f4220a90"
	"github.com/prometheus/common v0.4.1"
	"github.com/prometheus/procfs v0.0.2"
	"github.com/stretchr/testify v1.3.0" # indirect

	"github.com/alecthomas/template a0175ee3bccc" ## indirect
	"github.com/alecthomas/units 2efee857e7cf" # indirect
	"github.com/beorn7/perks 3a771d992973" # indirect
	"github.com/go-kit/kit v0.8.0"
	"github.com/go-logfmt/logfmt v0.3.0" # indirect
	"github.com/go-stack/stack v1.8.0" # indirect
	"github.com/gogo/protobuf v1.1.1" # indirect
	"github.com/golang/protobuf v1.2.0"
	"github.com/julienschmidt/httprouter v1.2.0"
	"github.com/kr/logfmt b84e30acd515" # indirect
	"github.com/matttproud/golang_protobuf_extensions v1.0.1"
	"github.com/mwitkow/go-conntrack cc309e4a2223"
	"github.com/pkg/errors v0.8.0"
	"github.com/prometheus/client_golang v0.9.1"
	"github.com/prometheus/client_model 5c3871d89910"
	"github.com/prometheus/procfs 185b4288413d" # indirect
	"github.com/sirupsen/logrus v1.2.0"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6 github.com/alecthomas/kingpin"

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
KEYWORDS="~amd64 ~arm64 ~x86"

#extracted from go.mod
DEPEND=">=dev-lang/go-1.11.6
	>=dev-go/fetchbot-1.1.2
	>=dev-go/goquery-1.5.0
	>=dev-go/uuid-1.1.1
	>=dev-go/cascadia-1.0.0
	>=dev-go/robotstxt-go-20180810
	dev-go/go-crypto
	dev-go/go-oauth2
	dev-go/go-sys"

#https://bugs.gentoo.org/673704
#	dev-go/gopkg-sourcemap

RDEPEND="${DEPEND}"

#https://github.com/golang/go/issues/27348
#src_prepare() {
#	cd src/${EGO_PN}
#	go mod verify
#	eapply_user
#}

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
	go install -v -work -x ${EGO_BUILD_FLAGS} ./...
}

src_install(){
	dobin bin/amass*
}
