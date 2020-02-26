# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/bettercap/bettercap"
EGO_VENDOR=( # bettercap release comes with almost all deps in ./vendor/ directory
#	"github.com/adrianmo/go-nmea v1.1.0"
#	"github.com/antchfx/jsonquery a2896be"
#	"github.com/antchfx/xpath v1.0.0"
#	"github.com/bettercap/gatt 3c65008"
#	"github.com/bettercap/nrf24 aa37e6d"
#	"github.com/bettercap/readline v1.4"
	"github.com/bettercap/recording 3ce1dcf"
#	"github.com/chifflier/nfqueue-go 61ca646"
#	"github.com/dustin/go-humanize 9f541cc"
#	"github.com/elazarl/goproxy 473e67f"
#	"github.com/evilsocket/islazy v1.10.4"
#	"github.com/gobwas/glob e7a84e9"
#	"github.com/google/go-github v15.0.0"
#	"github.com/google/go-querystring v1.0.0"
#	"github.com/google/gopacket v1.1.16"
#	"github.com/google/gousb 18f4c1d"
#	"github.com/gorilla/mux v1.7.3"
#	"github.com/gorilla/websocket v1.4.1"
#	"github.com/hashicorp/mdns v1.0.1"
#	"github.com/inconshreveable/go-vhost 06d8411"
#	"github.com/jpillora/go-tld f16ca3b"
#	"github.com/kr/binarydist v0.1.0"
#	"github.com/malfunkt/iprange v0.9.0"
#	"github.com/mattn/go-colorable v0.1.2"
#	"github.com/mattn/go-isatty v0.0.9"
#	"github.com/mdlayher/dhcp6 2a67805"
#	"github.com/mdlayher/raw 480b937"
#	"github.com/mgutz/ansi 9520e82"
#	"github.com/mgutz/logxi v1"
#	"github.com/miekg/dns v1.1.17"
#	"github.com/mitchellh/go-homedir v1.1.0"
#	"github.com/robertkrimen/otto 15f95af"
#	"github.com/tarm/serial 98f6abe"
#	"gopkg.in/sourcemap.v1 v1.0.5 github.com/go-sourcemap/sourcemap"
)

inherit golang-vcs-snapshot

DESCRIPTION="A complete, modular, portable and easily extensible MITM framework"
HOMEPAGE="https://github.com/bettercap/bettercap/"

SRC_URI="https://github.com/bettercap/bettercap/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="
	net-libs/libpcap
	net-libs/libnetfilter_queue
	net-libs/libnfnetlink
	virtual/libusb:*"

#DEPEND="${RDEPEND}
#	dev-go/go-sys:=
#	dev-go/go-crypto:=
#	dev-go/go-net:0="

BDEPEND="dev-lang/go"

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
}
