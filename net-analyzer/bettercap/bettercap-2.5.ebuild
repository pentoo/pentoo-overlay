# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=(
	"github.com/adrianmo/go-nmea 22095aa1b48050243d3eb9a001ca80eb91a0c6fa"
	"github.com/bettercap/gatt 6475b946a0bff32e906c25d861f2b1c6d2056baa"
	"github.com/bettercap/readline 62c6fe6193755f722b8b8788aa7357be55a50ff1"
	"github.com/chifflier/nfqueue-go 61ca646babef3bd4dea1deb610bfb0005c0a1298"
	"github.com/dustin/go-humanize bb3d318650d48840a39aa21a027c6630e198e626"
	"github.com/elazarl/goproxy a96fa3a318260eab29abaf32f7128c9eb07fb073"
	"github.com/google/go-github e48060a28fac52d0f1cb758bc8b87c07bac4a87d"
	"github.com/google/go-querystring 53e6ce116135b80d037921a7fdd5138cf32d7a8a"
	"github.com/gorilla/context 08b5f424b9271eedf6f9f0ce86cb9396ed337a42"
	"github.com/inconshreveable/go-vhost 06d84117953b22058c096b49a429ebd4f3d3d97b"
	"github.com/jpillora/go-tld a31ae10e978ab5f352c5dad2cfbd60546dcea75f"
	"github.com/malfunkt/iprange 3a31f5ed42d2d8a1fc46f1be91fd693bdef2dd52"
	"github.com/mattn/go-colorable 5411d3eea5978e6cdc258b30de592b60df6aba96"
	"github.com/mdlayher/dhcp6 e26af0688e455a82b14ebdbecf43f87ead3c4624"
	"github.com/mgutz/ansi 9520e82c474b0a04dd04f8a40959027271bab992"
	"github.com/mgutz/logxi aebf8a7d67ab4625e0fd4a665766fef9a709161b"
	"github.com/pkg/errors 30136e27e2ac8d167177e8a583aa4c3fea5be833"
	"github.com/robertkrimen/otto 6c383dd335ef8dcccef05e651ce1eccfe4d0f011"
	"github.com/tarm/serial eaafced92e9619f03c72527efeab21e326f3bc36"
	"golang.org/x/sys abf9c25f54453410d0c6668e519582a9e1115027 github.com/golang/sys"
	"gopkg.in/sourcemap.v1 6e83acea0053641eff084973fee085f0c193c61a github.com/go-sourcemap/sourcemap"
)

#	"github.com/mattn/go-isatty 0360b2af4f38e8d38c7fce2a9f4e702702d73a39"
#	"github.com/google/gopacket 11c65f1ca9081dfea43b4f9643f5c155583b73ba"
#	"github.com/gorilla/mux 53c1911da2b537f792e7cafcb446b05ffe33b996"
#	"github.com/gorilla/websocket ea4d1f681babbce9545c9c5f3d5194a789c89f5b"

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

#FIXME: add stable versions: iprage go-colorable
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
