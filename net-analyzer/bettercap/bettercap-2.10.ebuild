# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"github.com/bettercap/gatt 66e7446993acb3de936b3f487e5933522ed16923"
	"github.com/bettercap/readline 62c6fe6193755f722b8b8788aa7357be55a50ff1"
	"github.com/chifflier/nfqueue-go 61ca646babef3bd4dea1deb610bfb0005c0a1298"
	"github.com/dustin/go-humanize 02af3965c54e8cacf948b97fef38925c4120652c"
	"github.com/elazarl/goproxy a96fa3a318260eab29abaf32f7128c9eb07fb073"
	"github.com/gobwas/glob f00a7392b43971b2fdb562418faab1f18da2067a"
	"github.com/google/go-github e48060a28fac52d0f1cb758bc8b87c07bac4a87d"
	"github.com/inconshreveable/go-vhost 06d84117953b22058c096b49a429ebd4f3d3d97b"
	"github.com/jpillora/go-tld a31ae10e978ab5f352c5dad2cfbd60546dcea75f"
	"github.com/malfunkt/iprange 3a31f5ed42d2d8a1fc46f1be91fd693bdef2dd52"
	"github.com/mdlayher/dhcp6 e26af0688e455a82b14ebdbecf43f87ead3c4624"
	"github.com/robertkrimen/otto 03d472dc43abece8691e609a23d295ab732abba6"
	"github.com/tarm/serial eaafced92e9619f03c72527efeab21e326f3bc36"
	"github.com/adrianmo/go-nmea 22095aa1b48050243d3eb9a001ca80eb91a0c6fa"
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
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

#FIXME: add stable versions, see Gopkg.lock, "version"
DEPEND="dev-go/go-isatty
	dev-go/gopacket
	dev-go/mux
	dev-go/websocket
	"

RDEPEND="net-libs/libpcap
	net-libs/libnetfilter_queue"

src_install(){
	dosbin bettercap
}
