# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1 linux-info systemd

# copy from daemon/go.mod
# old: go mod vendor && grep "# g" ./vendor/modules.txt | sort
#github.com/google/nftables use the latest version
EGO_PN="github.com/evilsocket/opensnitch"
EGO_VENDOR=(
	"github.com/evilsocket/ftrace v1.2.0"
	"github.com/fsnotify/fsnotify v1.5.1"
	"github.com/golang/protobuf v1.5.2"
	"github.com/google/gopacket v1.1.19"
	"github.com/google/nftables 950e408d48c671ccd9f4997a4b6eb95db21365d6"
	"github.com/iovisor/gobpf v0.2.0"
	"github.com/vishvananda/netlink v1.1.0"
	"github.com/vishvananda/netns 50045581ed74"
	"golang.org/x/net 27dd8689420f github.com/golang/net"
	"golang.org/x/sync 036812b2e83c github.com/golang/sync"
	"golang.org/x/sys 4e6760a101f9 github.com/golang/sys"
	"golang.org/x/text v0.3.7 github.com/golang/text"
	"google.golang.org/grpc v1.32.0 github.com/grpc/grpc-go"

	"google.golang.org/protobuf v1.27.1 github.com/protocolbuffers/protobuf-go"
	"google.golang.org/genproto 325a89244dc8 github.com/googleapis/go-genproto"
	"github.com/mdlayher/netlink v1.6.0"
	"github.com/josharian/native v1.0.0"
	"github.com/mdlayher/socket v0.2.2"
)

inherit golang-vcs-snapshot

DESCRIPTION="Desktop application firewall"
HOMEPAGE="https://github.com/evilsocket/opensnitch"

SRC_URI="https://github.com/evilsocket/opensnitch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="systemd"
KEYWORDS="~amd64 ~x86"

#	dev-go/go-text:=
DEPEND=">=dev-lang/go-1.13
	net-libs/libnetfilter_queue
	dev-go/go-protobuf
	dev-go/protoc-gen-go-grpc
	"
RDEPEND="
	dev-python/grpcio-tools[${PYTHON_USEDEP}]
	dev-python/python-slugify[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/PyQt5[sql,${PYTHON_USEDEP}]
"

CONFIG_CHECK="NETFILTER_XT_MATCH_CONNTRACK"

pkg_pretend() {
	linux-info_pkg_setup
}

src_prepare() {
	rm -r src/${EGO_PN}/ui/tests
	emake -C src/${EGO_PN} protocol
	cd src/${EGO_PN}/ui
	pyrcc5 -o opensnitch/resources_rc.py opensnitch/res/resources.qrc
	sed -i 's/^import ui_pb2/from . import ui_pb2/' opensnitch/ui_pb2*
	use systemd && cd "${WORKDIR}/${P}/src/${EGO_PN}" && eapply "${FILESDIR}/systemd.patch"
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
	doins default-config.json
	doins system-fw.json
	popd >/dev/null || die

	if use systemd; then
		pushd src/${EGO_PN}/daemon >/dev/null || die
		systemd_dounit opensnitchd.service
		popd >/dev/null || die
	else
		newinitd "${FILESDIR}"/opensnitch.initd ${PN}
	fi
}
