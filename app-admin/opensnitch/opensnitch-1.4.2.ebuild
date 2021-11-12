# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

# copy from daemon/go.mod
# old: go mod vendor && grep "# g" ./vendor/modules.txt | sort
EGO_PN="github.com/evilsocket/opensnitch"
EGO_VENDOR=(
	"github.com/evilsocket/ftrace v1.2.0"
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/golang/glog 23def4e6c14b"
	"github.com/golang/protobuf v1.5.0"
	"github.com/google/gopacket v1.1.14"
	"github.com/google/nftables a285acebcad3"
	"github.com/iovisor/gobpf v0.2.0"
	"github.com/vishvananda/netlink v1.1.0"
	"github.com/vishvananda/netns 0a2b9b5464df"
	"golang.org/x/net d8887717615a github.com/golang/net"
	"golang.org/x/sync 6e8e738ad208 github.com/golang/sync"
	"golang.org/x/sys 7fc4e5ec1444 github.com/golang/sys"
	"golang.org/x/text v0.3.0 github.com/golang/text"
	"google.golang.org/grpc v1.27.0 github.com/grpc/grpc-go"
	"google.golang.org/protobuf v1.26.0 github.com/protocolbuffers/protobuf-go"
	"google.golang.org/genproto 7fd901a49ba6 github.com/googleapis/go-genproto"
	"github.com/koneu/natend ec0926ea948d1549773caebd030b217dc31ba55c"
	"github.com/mdlayher/netlink v1.4.1"
	"github.com/josharian/native b6b71def0850a2fbd7e6875f8e28217a48c5bcb4"
	"github.com/mdlayher/socket 9dbe287ded84b2af7d29eedef2693df69e11ce74"
)

inherit golang-vcs-snapshot

DESCRIPTION="Desktop application firewall"
HOMEPAGE="https://github.com/evilsocket/opensnitch"

SRC_URI="https://github.com/evilsocket/opensnitch/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

#	dev-go/go-text:=
DEPEND=">=dev-lang/go-1.13
	net-libs/libnetfilter_queue
	dev-go/go-protobuf
	"
RDEPEND="
	dev-python/grpcio-tools[${PYTHON_USEDEP}]
	dev-python/python-slugify[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/PyQt5[sql,${PYTHON_USEDEP}]
"
#FIXME: add config check:
#CONFIG_NETFILTER_XT_MATCH_CONNTRACK

src_prepare() {
	emake -C src/${EGO_PN} protocol
	cd src/${EGO_PN}/ui
	pyrcc5 -o opensnitch/resources_rc.py opensnitch/res/resources.qrc
	sed -i 's/^import ui_pb2/from . import ui_pb2/' opensnitch/ui_pb2*
	eapply_user
}

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" "${EGO_PN}/daemon" || die

	pushd src/${EGO_PN}/ui >/dev/null || die
	distutils-r1_src_compile
	popd >/dev/null || die
}

src_install(){
	newbin daemon opensnitchd

	pushd src/${EGO_PN}/ui >/dev/null || die
	distutils-r1_src_install
	popd >/dev/null || die

	pushd src/${EGO_PN}/daemon >/dev/null || die
	insinto /etc/opensnitchd/rules
	insinto /etc/opensnitchd/
#	@cp opensnitchd.service /etc/systemd/system/
	doins default-config.json
	doins system-fw.json
	popd >/dev/null || die

	newinitd "${FILESDIR}"/opensnitch.initd ${PN}

}
