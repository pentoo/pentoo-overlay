# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_PN="github.com/bettercap/bettercap"
EGO_VENDOR=(
	"github.com/adrianmo/go-nmea v1.1.0"
	"github.com/antchfx/jsonquery v1.0.0"
	"github.com/antchfx/xpath v1.1.0"
	"github.com/bettercap/gatt 569d3d9372bb"
	"github.com/bettercap/nrf24 aa37e6d0e0eb"
	"github.com/bettercap/readline 9cec905dd291"
	"github.com/bettercap/recording 3ce1dcf032e3"
	"github.com/chifflier/nfqueue-go 61ca646babef"
	"github.com/dustin/go-humanize v1.0.0"
	"github.com/elazarl/goproxy aa519ddbe484"
	"github.com/evilsocket/islazy v1.10.4"
	"github.com/gobwas/glob e7a84e9525fe"
	"github.com/google/go-github v17.0.0"
	"github.com/google/gopacket v1.1.17"
	"github.com/google/go-querystring v1.0.0"
	"github.com/google/gousb 18f4c1d8a750"
	"github.com/gorilla/mux v1.7.3"
	"github.com/gorilla/websocket v1.4.1"
	"github.com/hashicorp/mdns v1.0.1"
	"github.com/inconshreveable/go-vhost 06d84117953b"
	"github.com/jpillora/go-tld f16ca3b7b383"
	"github.com/kr/binarydist v0.1.0"
	"github.com/malfunkt/iprange v0.9.0"
	"github.com/mattn/go-colorable v0.1.4"
	"github.com/mattn/go-isatty v0.0.10"
	"github.com/mdlayher/dhcp6 2a67805d7d0b"
	"github.com/mgutz/ansi 9520e82c474b"
	"github.com/mgutz/logxi aebf8a7d67ab"
	"github.com/miekg/dns v1.1.22"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/pkg/errors v0.8.1"
	"github.com/robertkrimen/otto 15f95af6e78d"
	"github.com/tarm/serial 98f6abe2eb07"
	"golang.org/x/crypto 87dc89f01550 github.com/golang/crypto"
	"golang.org/x/net da9a3fd4c582 github.com/golang/net"
	"golang.org/x/sys 727590c5006e github.com/golang/sys"
#	"gopkg.in/sourcemap.v1 v1.0.5 github.com/go-sourcemap/sourcemap"
)

inherit golang-vcs-snapshot

DESCRIPTION="A complete, modular, portable and easily extensible MITM framework"
HOMEPAGE="https://github.com/bettercap/bettercap/"

SRC_URI="https://github.com/bettercap/bettercap/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RESTRICT="mirror"

RDEPEND="
	net-libs/libpcap
	net-libs/libnetfilter_queue
	net-libs/libnfnetlink
	virtual/libusb:*"
DEPEND="${RDEPEND}
	=dev-go/gopkg-sourcemap-1*
	"

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
