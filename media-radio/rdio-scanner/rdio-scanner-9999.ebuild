# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

EGO_PN="github.com/chuot/rdio-scanner"

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_VENDOR=(
	"github.com/dhowden/tag v0.0.0-20201120070457-d52dcb253c63"
	"github.com/fsnotify/fsnotify v1.5.1"
	"github.com/go-sql-driver/mysql v1.6.0"
	"github.com/golang-jwt/jwt/v4 v4.1.0"
	"github.com/google/uuid v1.3.0"
	"github.com/gorilla/websocket v1.4.2"
	"github.com/kardianos/service v1.2.0"
	"github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51"
	"github.com/mattn/go-isatty v0.0.14"
	"github.com/remyoudompheng/bigfft v0.0.0-20200410134404-eec4a21b6bb0"
	"github.com/stretchr/testify v1.7.0"
	"golang.org/x/crypto v0.0.0-20211117183948-ae814b36b871"
	"golang.org/x/mod v0.5.1"
	"golang.org/x/net v0.0.0-20211123203042-d83791d6bcd9"
	"golang.org/x/sys v0.0.0-20211124211545-fe61309f8881"
	"golang.org/x/text v0.3.7"
	"golang.org/x/tools v0.1.7"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1"
	"gopkg.in/ini.v1 v1.66.0"
)

inherit golang-vcs-snapshot

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/chuot/rdio-scanner.git"
EGIT_BRANCH="v6-beta"
SRC_URI="${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc"

DEPEND="doc? ( app-text/pandoc )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	cd server || die
	GOPATH="${S}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
	go build -v -work -x -ldflags "-w -X ${EGO_PN}.Version=${PV}" ./... || die
}

src_install() {
	cd server || die
	GOPATH="${S}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
	go install -v -work -x -ldflags "-w -X ${MY_EGO_PN}.Version=${PV}" ./... || die
}
