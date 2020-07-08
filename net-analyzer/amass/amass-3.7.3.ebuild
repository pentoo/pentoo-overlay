# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_PN="github.com/OWASP/Amass"
EGO_VENDOR=(
	"github.com/alexbrainman/sspi e580b900e9f5"
	"github.com/AndreasBriese/bbloom 46b345b51c96"
	"github.com/andybalholm/cascadia v1.2.0"
	"github.com/beorn7/perks v1.0.1"
	"github.com/boltdb/bolt v1.3.1"
	"github.com/cayleygraph/cayley v0.7.7"
	"github.com/cayleygraph/quad v1.2.4"
	"github.com/cenkalti/backoff v2.2.1"
	"github.com/cespare/xxhash/v2 v2.1.1 github.com/cespare/xxhash"
	"github.com/chromedp/cdproto 0de008e41fa0"
	"github.com/chromedp/chromedp v0.5.3"
	"github.com/cjoudrey/gluaurl 31cbb9bef199"
	"github.com/dennwc/base v1.0.0"
	"github.com/dghubble/go-twitter 39e5462e111f"
	"github.com/dghubble/sling v1.3.0"
	"github.com/fatih/color v1.9.0"
	"github.com/geziyor/geziyor cfb16fe1ee0e"
	"github.com/gobuffalo/logger v1.0.3"
	"github.com/gobuffalo/packd v1.0.0"
	"github.com/gobuffalo/packr v2.8.0"
	"github.com/gobwas/httphead 2c6c146eadee"
	"github.com/gobwas/pool v0.2.0"
	"github.com/gobwas/ws v1.0.3"
	"github.com/gogo/protobuf v1.3.1"
	"github.com/go-ini/ini v1.57.0"
	"github.com/go-kit/kit v0.10.0"
	"github.com/golang/protobuf v1.4.2"
	"github.com/google/go-querystring v1.0.0"
	"github.com/google/uuid v1.1.1"
	"github.com/gorilla/websocket v1.4.2"
	"github.com/hashicorp/go-uuid v1.0.2"
	"github.com/hidal-go/hidalgo 42e03f3b5eaa"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jcmturner/aescts v2.0.0"
	"github.com/jcmturner/dnsutils v2.0.0"
	"github.com/jcmturner/gofork v1.0.0"
	"github.com/jcmturner/goidentity v6.0.1"
	"github.com/jcmturner/gokrb5 v8.3.0"
	"github.com/jcmturner/rpc v2.0.2"
	"github.com/jmoiron/sqlx v1.2.0"
	"github.com/karrick/godirwalk v1.15.6"
	"github.com/knq/sysutil 15668db23d08"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2"
	"github.com/lib/pq v1.6.0"
	"github.com/mailru/easyjson v0.7.1"
	"github.com/markbates/errx v1.1.0"
	"github.com/markbates/oncer v1.0.0"
	"github.com/markbates/safe v1.0.1"
	"github.com/mattn/go-colorable v0.1.6"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/matttproud/golang_protobuf_extensions v1.0.1"
	"github.com/miekg/dns v1.1.29"
	"github.com/northwesternmutual/grammes v1.1.2"
	"github.com/pkg/errors v0.9.1"
	"github.com/prometheus/client_golang v1.6.0"
	"github.com/prometheus/client_model v0.2.0"
	"github.com/prometheus/common v0.10.0"
	"github.com/prometheus/procfs v0.0.11"
	"github.com/PuerkitoBio/goquery v1.5.1"
	"github.com/rakyll/statik v0.1.7"
	"github.com/rogpeppe/go-internal v1.6.0"
	"github.com/sirupsen/logrus v1.6.0"
	"github.com/spf13/cobra v1.0.0"
	"github.com/spf13/pflag v1.0.5"
	"github.com/temoto/robotstxt v1.1.1"
	"github.com/tylertreat/BoomFilters 42a7b4300c0c"
	"github.com/VividCortex/gohistogram v1.0.0"
	"github.com/yuin/gluare d7c94f1a80ed"
	"github.com/yuin/gopher-lua dc2b0ca8b37e"
	"golang.org/x/crypto 70a84ac30bf9 github.com/golang/crypto"
	"golang.org/x/lint 738671d3881b github.com/golang/lint"
	"golang.org/x/net 627f9648deb9 github.com/golang/net"
	"golang.org/x/oauth2 bf48bf16ab8d github.com/golang/oauth2"
	"golang.org/x/sync 43a5402ce75a  github.com/golang/sync"
	"golang.org/x/sys 6fdc65e7d980 github.com/golang/sys"
	"golang.org/x/text v0.3.2 github.com/golang/text"
	"golang.org/x/tools cef9fc3bc8f0 github.com/golang/tools"
	"google.golang.org/appengine v1.6.6 github.com/golang/appengine"
	"google.golang.org/protobuf v1.24.0 github.com/protocolbuffers/protobuf-go"
	"gopkg.in/ini.v1 v1.55.0 github.com/go-ini/ini"
	"go.uber.org/atomic v1.6.0 github.com/uber-go/atomic"
	"go.uber.org/multierr v1.5.0 github.com/uber-go/multierr"
	"go.uber.org/zap v1.15.0 github.com/uber-go/zap"

	"layeh.com/gopher-json 97fed8db84274c421dbfffbb28ec859901556b97 github.com/layeh/gopher-json"
)

inherit golang-vcs-snapshot

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/OWASP/Amass"

SRC_URI="https://github.com/OWASP/Amass/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
