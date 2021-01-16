# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_PN="github.com/OWASP/Amass"
EGO_VENDOR=(
	"github.com/AndreasBriese/bbloom 46b345b51c96"
	"github.com/andybalholm/cascadia v1.1.0"
	"github.com/beorn7/perks v1.0.0"
	"github.com/boltdb/bolt v1.3.1"
	"github.com/caffix/eventbus 4c5f3ce94295"
	"github.com/caffix/pipeline 41730a0744af"
	"github.com/caffix/queue 1d2e72b64fa0"
	"github.com/caffix/service 354b1fdf7f24"
	"github.com/caffix/stringset 37e95a70826c"
	"github.com/cayleygraph/cayley v0.7.7"
	"github.com/cayleygraph/quad v1.2.4"
	"github.com/cenkalti/backoff v2.1.1"
	"github.com/chromedp/cdproto 6626966fbae4"
	"github.com/chromedp/chromedp v0.5.2"
	"github.com/cjoudrey/gluaurl 31cbb9bef199"
	"github.com/cloudflare/cloudflare-go v0.13.6"
	"github.com/dennwc/base v1.0.0"
	"github.com/dghubble/go-twitter 4b180d0cc78d"
	"github.com/dghubble/sling v1.3.0"
	"github.com/fatih/color v1.10.0"
	"github.com/geziyor/geziyor cfb16fe1ee0e"
	"github.com/gobuffalo/envy v1.7.1"
	"github.com/gobuffalo/logger v1.0.1"
	"github.com/gobuffalo/packd v0.3.0"
	"github.com/gobuffalo/packr v2.7.1"
	"github.com/gobwas/httphead 2c6c146eadee"
	"github.com/gobwas/pool v0.2.0"
	"github.com/gobwas/ws v1.0.2"
	"github.com/gogo/protobuf v1.3.0"
	"github.com/go-ini/ini v1.62.0"
	"github.com/go-kit/kit v0.8.0"
	"github.com/golang/protobuf v1.4.2"
	"github.com/google/go-querystring v1.0.0"
	"github.com/google/uuid v1.1.3"
	"github.com/go-sql-driver/mysql v1.4.1"
	"github.com/hashicorp/errwrap v1.1.0"
	"github.com/hashicorp/go-multierror v1.1.0"
	"github.com/hidal-go/hidalgo 42e03f3b5eaa"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jmoiron/sqlx v1.2.0"
	"github.com/joho/godotenv v1.3.0"
	"github.com/knq/sysutil 15668db23d08"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.3"
	"github.com/lib/pq v1.9.0"
	"github.com/mailru/easyjson v0.7.0"
	"github.com/mattn/go-colorable v0.1.8"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/matttproud/golang_protobuf_extensions v1.0.1"
	"github.com/miekg/dns v1.1.31"
	"github.com/pkg/errors v0.9.1"
	"github.com/prometheus/client_golang v1.0.0"
	"github.com/prometheus/client_model 14fe0d1b01d4"
	"github.com/prometheus/common v0.4.1"
	"github.com/prometheus/procfs v0.0.2"
	"github.com/PuerkitoBio/goquery v1.6.0"
	"github.com/rakyll/statik v0.1.7"
	"github.com/rogpeppe/go-internal v1.5.0"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/smartystreets/goconvey v1.6.4"
	"github.com/spf13/cobra v0.0.5"
	"github.com/spf13/pflag v1.0.5"
	"github.com/temoto/robotstxt v1.1.1"
	"github.com/tylertreat/BoomFilters 611b3dbe80e8"
	"github.com/VividCortex/gohistogram v1.0.0"
	"github.com/yl2chen/cidranger v1.0.2"
	"github.com/yuin/gopher-lua ee81675732da"
	"golang.org/x/crypto 75b288015ac9 github.com/golang/crypto"
	"golang.org/x/net 6772e930b67b github.com/golang/net"
	"golang.org/x/oauth2 08078c50e5b5 github.com/golang/oauth2"
	"golang.org/x/sync 09787c993a3a  github.com/golang/sync"
	"golang.org/x/sys f84b799fce68 github.com/golang/sys"
	"golang.org/x/text v0.3.3 github.com/golang/text"
	"golang.org/x/time 3af7569d3a1e github.com/golang/time"
	"golang.org/x/tools b303f430e36d github.com/golang/tools"
	"google.golang.org/appengine v1.6.6 github.com/golang/appengine"
	"google.golang.org/protobuf v1.25.0 github.com/protocolbuffers/protobuf-go"
	"gopkg.in/ini.v1 v1.62.0 github.com/go-ini/ini"
	"go.uber.org/ratelimit v0.1.0 github.com/uber-go/ratelimit"

	"layeh.com/gopher-json 97fed8db84274c421dbfffbb28ec859901556b97 github.com/layeh/gopher-json"
)

inherit golang-vcs-snapshot

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/OWASP/Amass"

SRC_URI="https://github.com/OWASP/Amass/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RESTRICT="mirror"

BDEPEND=">=dev-lang/go-1.13"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-w" ./... || die
}

src_install(){
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-w" ./... || die

	dobin bin/amass
}
