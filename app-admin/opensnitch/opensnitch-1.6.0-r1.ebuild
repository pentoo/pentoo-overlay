# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 linux-info systemd xdg-utils

DESCRIPTION="Desktop application firewall"
HOMEPAGE="https://github.com/evilsocket/opensnitch"

EGO_PN="github.com/evilsocket/opensnitch"
# modified from opensnitch/daemon/go.mod
# NOTE: build fails with github.com/josharian/native after commit 5c7d0dd6ab
EGO_VENDOR=(
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/golang/protobuf v1.5.0"
	"github.com/google/gopacket v1.1.14"
	"github.com/google/nftables v0.1.0"
	"github.com/google/uuid v1.3.0"
	"github.com/iovisor/gobpf v0.2.0"
	"github.com/varlink/go v0.4.0"
	"github.com/vishvananda/netlink e1a867c6b452"
	"golang.org/x/net 491a49abca63 github.com/golang/net"
	"golang.org/x/sys v0.2.0 github.com/golang/sys"
	"google.golang.org/grpc v1.32.0 github.com/grpc/grpc-go"
	"google.golang.org/protobuf v1.27.1 github.com/protocolbuffers/protobuf-go"

	"golang.org/x/sync v0.1.0 github.com/golang/sync"
	"golang.org/x/text v0.7.0 github.com/golang/text"
	"google.golang.org/genproto 0dfe4f8abfcc github.com/googleapis/go-genproto"
	"github.com/mdlayher/netlink v1.7.1"
	"github.com/mdlayher/socket 41a913f399"
	"github.com/josharian/native v1.1.0"
	"github.com/vishvananda/netns 7a452d2d15"
)

inherit golang-vcs-snapshot

SRC_URI="
	https://github.com/evilsocket/opensnitch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}
"

LICENSE="GPL-3"
SLOT="0"
IUSE="+audit bpf +iptables +nftables systemd"
REQUIRED_USE="|| ( iptables nftables )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-lang/go-1.19
	net-libs/libnetfilter_queue
	dev-go/go-protobuf
	dev-go/protoc-gen-go-grpc
"
RDEPEND="
	dev-python/grpcio-tools[${PYTHON_USEDEP}]
	dev-python/notify2[${PYTHON_USEDEP}]
	dev-python/python-slugify[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/PyQt5[sql,${PYTHON_USEDEP}]
	bpf? ( ~app-admin/opensnitch-ebpf-module-$PV )
"

RESTRICT+=" test"

pkg_setup() {
	# see https://github.com/evilsocket/opensnitch/discussions/978
	local CONFIG_CHECK="
		INET_TCP_DIAG
		INET_UDP_DIAG
		INET_RAW_DIAG
		INET_DIAG_DESTROY
		NETFILTER_NETLINK_ACCT
		NETFILTER_NETLINK_QUEUE
		NF_CONNTRACK
		NF_CT_NETLINK
		PROC_FS
	"

	# config needed for the audit monitoring method
	use audit && CONFIG_CHECK+="
		AUDIT
	"

	# config needed for using iptables as firewall
	use iptables && CONFIG_CHECK+="
		NETFILTER_XT_MATCH_CONNTRACK
		NETFILTER_XT_TARGET_NFQUEUE
	"

	# config needed for using nftables as firewall
	use nftables && CONFIG_CHECK+="
		NFT_CT
		NFT_QUEUE
	"

	linux-info_pkg_setup
}

src_prepare() {
	rm -rf src/${EGO_PN}/ui/tests || die

	if use systemd; then
		pushd ${WORKDIR}/${P}/src/${EGO_PN} > /dev/null || die
		eapply "${FILESDIR}/${P}-systemd.patch"
		popd > /dev/null || die
	fi

	pushd src/${EGO_PN} > /dev/null || die
	eapply_user
	popd > /dev/null || die
}

src_compile() {
	emake -C src/${EGO_PN} protocol

	pushd src/${EGO_PN}/ui > /dev/null || die
	pyrcc5 -o opensnitch/{resources_rc.py,/res/resources.qrc}
	# workaround for namespace conflict
	# see https://github.com/evilsocket/opensnitch/issues/496
	# and https://github.com/evilsocket/opensnitch/pull/442
	sed -i 's/^import ui_pb2/from . import ui_pb2/' opensnitch/ui_pb2* || die
	popd > /dev/null || die

	# see https://github.com/evilsocket/opensnitch/issues/851
	# opensnitch does not build without -fcf-protection when using go >= 1.19,
	# error message:
	# cgo: cannot load DWARF output from $WORK/..//_cgo_.o: zlib: invalid header
	GOPATH="${S}:$(get_golibdir_gopath)" \
	GOCACHE="${T}/go-cache" \
	CGO_CPPFLAGS="${CPPFLAGS} -fcf-protection" \
	CGO_CFLAGS="${CFLAGS} -fcf-protection" \
	CGO_CXXFLAGS="${CXXFLAGS} -fcf-protection" \
	go build -v \
		-buildmode=pie \
		-ldflags "-compressdwarf=false -linkmode external" \
		-o opensnitchd \
		"${EGO_PN}/daemon" || die

	pushd src/${EGO_PN}/ui > /dev/null || die
	distutils-r1_src_compile
	popd > /dev/null || die
}

src_install(){
	dobin opensnitchd

	pushd src/${EGO_PN}/ui > /dev/null || die
	distutils-r1_src_install
	popd > /dev/null || die

	pushd src/${EGO_PN}/daemon > /dev/null || die
	insinto /etc/opensnitchd/rules
	insinto /etc/opensnitchd/
	doins default-config.json
	doins system-fw.json
	popd > /dev/null || die

	if use systemd; then
		pushd src/${EGO_PN}/daemon > /dev/null || die
		systemd_dounit opensnitchd.service
		popd > /dev/null || die
	else
		newinitd "${FILESDIR}"/opensnitch.initd ${PN}
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
}
