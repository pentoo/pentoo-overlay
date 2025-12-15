# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 go-module linux-info systemd xdg-utils

DESCRIPTION="Desktop application firewall"
HOMEPAGE="https://github.com/evilsocket/opensnitch"

SRC_URI="
	https://github.com/evilsocket/opensnitch/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${P}-vendor.tar.xz
	"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

IUSE="+audit bpf +iptables +nftables systemd"
REQUIRED_USE="|| ( iptables nftables )"

DEPEND=">=dev-lang/go-1.19
	net-libs/libnetfilter_queue
	dev-go/protobuf-go
	dev-go/protoc-gen-go-grpc
"
RDEPEND="
	dev-python/pyqt6[network,sql,${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/grpcio-tools[${PYTHON_USEDEP}]
	dev-python/python-slugify[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/notify2[${PYTHON_USEDEP}]
	dev-python/qt-material[${PYTHON_USEDEP}]
	dev-python/pyside[${PYTHON_USEDEP}]

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

PATCHES=(
	"${FILESDIR}/fix-setup.py.patch"
)

src_unpack() {
	unpack ${A} # skip go module verification
}

src_prepare() {
	rm -rf ui/tests || die
	use systemd && eapply "${FILESDIR}/systemd.patch"
	default
}

src_compile() {
	emake protocol || die

	pushd ui || die
	pyside6-rcc -o opensnitch/{resources_rc.py,/res/resources.qrc} || die
	# workaround for namespace conflict
	# see https://github.com/evilsocket/opensnitch/issues/496
	# and https://github.com/evilsocket/opensnitch/pull/442
	#sed -i 's/^from . import ui_pb2/import opensnitch.proto.ui_pb2/' opensnitch/proto/ui_pb2_grpc.py || die
	sed -i 's/^import ui_pb2/import opensnitch.proto.ui_pb2/' opensnitch/proto/ui_pb2_grpc.py || die
	popd > /dev/null || die

	pushd daemon || die
	GOCACHE="${T}/go-cache" \
	GOMODCACHE="${WORKDIR}/${PN}-${PV}/vendor" \
	ego build -v -buildmode=pie -o opensnitchd || die
	popd > /dev/null || die

	pushd ui || die
	distutils-r1_src_compile
	popd > /dev/null || die
}

src_install(){
	pushd ui || die
	distutils-r1_src_install
	popd > /dev/null || die

	pushd daemon || die
	dobin opensnitchd
	keepdir /etc/opensnitchd/rules
	insinto /etc/opensnitchd/
	doins ./data/default-config.json
	doins ./data/network_aliases.json
	doins ./data/system-fw.json
	popd > /dev/null || die

	if use systemd; then
		pushd daemon || die
		systemd_dounit ./data/init/opensnitchd.service
		popd > /dev/null || die
	else
		newinitd "${FILESDIR}"/opensnitch.initd ${PN}
	fi
}

pkg_postinst() {
	xdg_icon_cache_update

	#FIXME upstream bug: https://github.com/evilsocket/opensnitch/issues/795
	elog "Under regular user, run the following commands to display IP's network name:"
	elog "cd ~/.config/opensnitch/"
	elog "wget https://github.com/hadiasghari/pyasn/blob/master/data/ipasn_20140513_v12.dat.gz?raw=true -O ipasn_db.dat.gz"
	elog  "wget https://github.com/hadiasghari/pyasn/blob/master/data/asnames.json?raw=true"

}
