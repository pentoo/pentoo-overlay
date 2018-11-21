# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"github.com/adrianmo/go-nmea a32116e4989e2b0e17c057ee378b4d5246add74e"
	"github.com/bettercap/gatt 66e7446993acb3de936b3f487e5933522ed16923"
	"github.com/bettercap/readline 62c6fe6193755f722b8b8788aa7357be55a50ff1"
	"github.com/chifflier/nfqueue-go 61ca646babef3bd4dea1deb610bfb0005c0a1298"
	"github.com/dustin/go-humanize 9f541cc9db5d55bce703bd99987c9d5cb8eea45e"
	"github.com/elazarl/goproxy f58a169a71a51037728990b2d3597a14f56b525b"
	"github.com/evilsocket/islazy 3d8400c74f9dbc626d913e0575cda05d914bea57"
	"github.com/gobwas/glob e7a84e9525fe90abcda167b604e483cc959ad4aa"
	"github.com/google/go-github e48060a28fac52d0f1cb758bc8b87c07bac4a87d"
	"github.com/google/go-querystring 44c6ddd0a2342c386950e880b658017258da92fc"

	"github.com/gorilla/context 08b5f424b9271eedf6f9f0ce86cb9396ed337a42"
	"github.com/inconshreveable/go-vhost 06d84117953b22058c096b49a429ebd4f3d3d97b"
	"github.com/jpillora/go-tld 4bfc8d9a90b591e101a56265afc2239359fb0810"
	"github.com/malfunkt/iprange 3a31f5ed42d2d8a1fc46f1be91fd693bdef2dd52"
	"github.com/mattn/go-colorable 167de6bfdfba052fa6b2d3664c8f5272e23c9072"

	"github.com/mdlayher/dhcp6 e26af0688e455a82b14ebdbecf43f87ead3c4624"
	"github.com/mdlayher/raw 67a536258490ec29bca6d465b51dea32c0db3623"
	"github.com/mgutz/ansi 9520e82c474b0a04dd04f8a40959027271bab992"
	"github.com/mgutz/logxi aebf8a7d67ab4625e0fd4a665766fef9a709161b"
	"github.com/pkg/errors 645ef00459ed84a119197bfb8d8205042c6df63d"
	"github.com/robertkrimen/otto 15f95af6e78dcd2030d8195a138bd88d4f403546"
	"github.com/tarm/serial 98f6abe2eb07edd42f6dfa2a934aea469acc29b7"
	"gopkg.in/sourcemap.v1 6e83acea0053641eff084973fee085f0c193c61a github.com/go-sourcemap/sourcemap"

)

EGO_PN=github.com/bettercap/bettercap

inherit golang-build golang-vcs-snapshot

EGIT_COMMIT="v${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz ${EGO_VENDOR_URI}"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"

DESCRIPTION="A complete, modular, portable and easily extensible MITM framework"
HOMEPAGE="https://github.com/bettercap/bettercap/"
LICENSE="GPL-3"
SLOT=0
IUSE=""
KEYWORDS="~amd64 ~arm ~arm64"

#FIXME: add stable versions, see Gopkg.lock, "version"
DEPEND="dev-go/go-isatty
	dev-go/gopacket
	dev-go/mux
	dev-go/websocket
	dev-go/go-net
	"

RDEPEND="net-libs/libpcap
	net-libs/libnetfilter_queue"

src_install(){
	dosbin bettercap
}
