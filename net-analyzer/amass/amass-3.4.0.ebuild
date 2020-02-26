# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#extracted from 'go mod vendor' -> grep "# g" ./vendor/modules.txt | sort file
EGO_VENDOR=(
	"github.com/andybalholm/cascadia v1.0.0"
	"github.com/beorn7/perks v1.0.0"
	"github.com/boltdb/bolt v1.3.1"
	"github.com/caffix/cloudflare-roundtripper 4c29d23"
	"github.com/cayleygraph/cayley v0.7.7"
	"github.com/cayleygraph/quad v1.1.0"
	"github.com/cenkalti/backoff v2.1.1"
	"github.com/chromedp/cdproto 39ef923"
	"github.com/chromedp/chromedp v0.4.1"
	"github.com/dennwc/base v1.0.0"
	"github.com/dghubble/go-twitter 39e5462"
	"github.com/dghubble/sling v1.3.0"
	"github.com/fatih/color v1.7.0"
	"github.com/geziyor/geziyor 9b8a383"
	"github.com/gobuffalo/envy v1.7.1"
	"github.com/gobuffalo/logger v1.0.1"
	"github.com/gobuffalo/packd v0.3.0"
	"github.com/gobuffalo/packr v2.7.1"
	"github.com/gobwas/httphead 2c6c146"
	"github.com/gobwas/pool v0.2.0"
	"github.com/gobwas/ws v1.0.2"
	"github.com/gogo/protobuf v1.3.0"
	"github.com/go-ini/ini v1.49.0"
	"github.com/go-kit/kit v0.8.0"
	"github.com/golang/protobuf v1.3.1"
	"github.com/google/go-querystring v1.0.0"
	"github.com/google/uuid v1.1.1"
	"github.com/hidal-go/hidalgo 42e03f3"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jmoiron/sqlx v1.2.0"
	"github.com/joho/godotenv v1.3.0"
	"github.com/knq/sysutil f05b59f"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2"
	"github.com/lib/pq v1.2.0"
	"github.com/mailru/easyjson b2ccc51"
	"github.com/mattn/go-colorable v0.1.4"
	"github.com/mattn/go-isatty v0.0.10"
	"github.com/matttproud/golang_protobuf_extensions v1.0.1"
	"github.com/miekg/dns v1.1.22"
	"github.com/pkg/errors v0.8.1"
	"github.com/prometheus/client_golang v1.0.0"
	"github.com/prometheus/client_model fd36f42"
	"github.com/prometheus/common v0.4.1"
	"github.com/prometheus/procfs v0.0.2"
	"github.com/PuerkitoBio/goquery v1.5.0"
	"github.com/robertkrimen/otto 15f95af6e78d"
	"github.com/rogpeppe/go-internal v1.5.0"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/spf13/cobra v0.0.5"
	"github.com/spf13/pflag v1.0.5"
	"github.com/temoto/robotstxt v1.1.1"
	"github.com/tylertreat/BoomFilters 611b3dbe80e8"
	"github.com/VividCortex/gohistogram v1.0.0"
#	"golang.org/x/crypto 34f69633bfdc"
#	"golang.org/x/net aa69164e4478"
#	"golang.org/x/oauth2 0f29369cfe45"
	"golang.org/x/oauth2 0f29369cfe45 github.com/golang/oauth2"
#	"golang.org/x/sync cd5d95a43a6e"
#	"golang.org/x/sys 06d7bd2c5f4f"
#	"golang.org/x/text v0.3.2"
#	"golang.org/x/tools 0337d82405ff"
#	"google.golang.org/appengine v1.6.1"
#	"gopkg.in/sourcemap.v1 v1.0.5"
	"gopkg.in/sourcemap.v1 v1.0.5 github.com/go-sourcemap/sourcemap" #indirect

)

EGO_PN=github.com/OWASP/Amass

inherit golang-vcs-snapshot

EGIT_COMMIT="v${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/OWASP/Amass"
LICENSE="Apache-2.0"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND=">=dev-lang/go-1.13
	>=dev-go/fetchbot-1.1.2
	>=dev-go/goquery-1.5.0
	>=dev-go/uuid-1.1.1
	>=dev-go/cascadia-1.0.0
	>=dev-go/robotstxt-go-20180810
	dev-go/go-crypto
	dev-go/go-net
	dev-go/go-sys
	dev-go/go-tools
"
#	dev-go/go-protobuf
#	dev-go/gogo-protobuf

#https://bugs.gentoo.org/673704
#	dev-go/gopkg-sourcemap

RDEPEND=""

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
	echo "CURRENT DIR: `pwd`"
	dobin bin/amass*
}
