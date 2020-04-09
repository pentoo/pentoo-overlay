# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/bettercap/bettercap"
EGO_VENDOR=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/adrianmo/go-nmea v1.1.0"
	"github.com/antchfx/jsonquery v1.0.0"
	"github.com/antchfx/xpath v1.1.0"
	"github.com/bettercap/gatt 569d3d9"
	"github.com/bettercap/nrf24 aa37e6d"
	"github.com/bettercap/readline 9cec905"
	"github.com/bettercap/recording 3ce1dcf"
	"github.com/chifflier/nfqueue-go 61ca646"
	"github.com/chzyer/logex v1.1.10"
	"github.com/chzyer/test a1ea475"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/dustin/go-humanize v1.0.0"
	"github.com/elazarl/goproxy aa519dd"
	"github.com/elazarl/goproxy/ext 473e67f github.com/elazarl/goproxy"
	"github.com/evilsocket/islazy v1.10.4"
	"github.com/gobwas/glob e7a84e9"
	"github.com/google/go-github v17.0.0"
	"github.com/google/go-querystring v1.0.0"
	"github.com/google/gopacket v1.1.17"
	"github.com/google/gousb 18f4c1d"
	"github.com/google/renameio v0.1.0"
	"github.com/gorilla/mux v1.7.3"
	"github.com/gorilla/websocket v1.4.1"
	"github.com/hashicorp/mdns v1.0.1"
	"github.com/inconshreveable/go-vhost 06d8411"
	"github.com/jpillora/go-tld f16ca3b"
	"github.com/kisielk/gotool v1.0.0"
	"github.com/kr/binarydist v0.1.0"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pty v1.1.1"
	"github.com/kr/text v0.1.0"
	"github.com/malfunkt/iprange v0.9.0"
	"github.com/mattn/go-colorable v0.1.4"
	"github.com/mattn/go-isatty v0.0.10"
	"github.com/mdlayher/dhcp6 2a67805"
	"github.com/mgutz/ansi 9520e82"
	"github.com/mgutz/logxi aebf8a7"
	"github.com/miekg/dns v1.1.22"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/pkg/errors v0.8.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/robertkrimen/otto 15f95af"
	"github.com/rogpeppe/go-charset 2471d30"
	"github.com/rogpeppe/go-internal v1.3.0"
	"github.com/stretchr/objx v0.1.0"
	"github.com/stretchr/testify v1.3.0"
	"github.com/tarm/serial 98f6abe"
	"golang.org/x/crypto 87dc89f github.com/golang/crypto"
	"golang.org/x/mod 4bf6d31 github.com/golang/mod"
	"golang.org/x/net da9a3fd github.com/golang/net"
	"golang.org/x/sync 1122301 github.com/golang/sync"
	"golang.org/x/sys 727590c github.com/golang/sys"
	"golang.org/x/text v0.3.2 github.com/golang/text"
	"golang.org/x/tools 2ca7180 github.com/golang/tools"
	"golang.org/x/xerrors a985d34 github.com/golang/xerrors"
	"gopkg.in/errgo.v2 v2.1.0 github.com/go-errgo/errgo"
	"gopkg.in/sourcemap.v1 v1.0.5 github.com/go-sourcemap/sourcemap"
	"honnef.co/go/tools 2020.1.3 github.com/dominikh/go-tools"
)

inherit golang-vcs-snapshot

DESCRIPTION="A complete, modular, portable and easily extensible MITM framework"
HOMEPAGE="https://github.com/bettercap/bettercap/"

SRC_URI="https://github.com/bettercap/bettercap/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="
	net-libs/libpcap
	net-libs/libnetfilter_queue
	net-libs/libnfnetlink
	virtual/libusb:*"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" ./... "${EGO_PN}" || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-s -w" ./... "${EGO_PN}" || die

	dosbin bin/bettercap
	dodoc "src/${EGO_PN}"/{{README,ISSUE_TEMPLATE}.md,Dockerfile}
}
