# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/michenriksen/aquatone"
EGO_VENDOR=(
	"github.com/asaskevich/EventBus d46933a"
	"github.com/asaskevich/govalidator v9"
	"github.com/cheggaaa/pb v2.0.6"
	"github.com/dgrijalva/jwt-go v3.2.0"
	"github.com/fatih/color v1.7.0"
	"github.com/go-redis/redis v6.15.1"
	"github.com/go-sql-driver/mysql v1.4.1"
	"github.com/go-stack/stack v1.8.0"
	"github.com/google/subcommands 46f0354"
	"github.com/hashicorp/go-version v1.1.0"
	"github.com/htcat/htcat v1.0.2"
	"github.com/inconshreveable/log15 v2.14"
	"github.com/jinzhu/gorm v1.9.2"
	"github.com/jinzhu/inflection 0414036"
	"github.com/k0kubun/pp v2.3.0"
	"github.com/knqyf263/go-cpe 659663f"
	"github.com/parnurzeal/gorequest v0.2.15"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/PuerkitoBio/goquery v1.4.1"
	"github.com/remeh/sizedwaitgroup 5e7302b"
	"github.com/labstack/echo v3.3.10"
	"github.com/labstack/gommon v0.2.8"
	"github.com/lair-framework/go-nmap 3b9bafd"
	"github.com/lib/pq v1.0.0"
	"github.com/mattn/go-colorable v0.0.9"
	"github.com/mattn/go-isatty v0.0.4"
	"github.com/mattn/go-runewidth v0.0.4"
	"github.com/mattn/go-sqlite3 v1.10.0"
	"github.com/moul/http2curl v1.0.0"
	"github.com/olekukonko/tablewriter v0.0.1"
	"github.com/pkg/errors v0.8.1"
	"github.com/valyala/bytebufferpool v1.0.0"
	"github.com/valyala/fasttemplate dcecefd"
	"github.com/mvdan/xurls v2.0.0"
	"google.golang.org/appengine v1.4.0 github.com/golang/appengine"
	"gopkg.in/VividCortex/ewma.v1 v1.1.1 github.com/VividCortex/ewma"
	"gopkg.in/cheggaaa/pb.v2 v2.0.6 github.com/cheggaaa/pb"
	"gopkg.in/fatih/color.v1 v1.7.0 github.com/fatih/color"
	"gopkg.in/mattn/go-colorable.v0 v0.0.9 github.com/mattn/go-colorable"
	"gopkg.in/mattn/go-isatty.v0 v0.0.4 github.com/mattn/go-isatty"
	"gopkg.in/mattn/go-runewidth.v0 v0.0.4 github.com/mattn/go-runewidth"
)

inherit eutils golang-vcs-snapshot

DESCRIPTION="A Tool for Domain Flyovers"
HOMEPAGE="https://github.com/michenriksen/aquatone https://michenriksen.com/blog/aquatone-now-in-go/"

SRC_URI="https://github.com/michenriksen/aquatone/archive/v${PV}.tar.gz -> ${P}.tar.gz
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
	>=dev-lang/go-1.12"

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
		src/"${EGO_PN}"/{README.md,CHANGELOG.md}
}
