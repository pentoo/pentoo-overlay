# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="eBPF process monitor module for opensnitch"
HOMEPAGE="https://github.com/evilsocket/opensnitch"
# NOTE: app-admin/opensnitch and this ebuild share the same source
SRC_URI="
	https://github.com/evilsocket/opensnitch/archive/refs/tags/v${PV}.tar.gz -> opensnitch-${PV}.tar.gz
"
S="${WORKDIR}/opensnitch-${PV}"
EBPF_DIR=ebpf_prog

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE="dist-kernel"

MINKV=5.5 # only compatible with kernels >= 5.5

RDEPEND="
	dist-kernel? ( virtual/dist-kernel:= )
	~app-admin/opensnitch-$PV
"

DEPEND="
	virtual/linux-sources
	>=sys-kernel/linux-headers-${MINKV}
"

BDEPEND="
	sys-devel/bc
	sys-devel/clang
	sys-devel/llvm
"

RESTRICT="strip test"
QA_PREBUILT="*"

pkg_setup() {
	# see https://github.com/evilsocket/opensnitch/discussions/978
	local CONFIG_CHECK="
		CGROUP_BPF
		BPF_EVENTS
		FTRACE_SYSCALLS
		KPROBES_ON_FTRACE
		KPROBE_EVENTS
		UPROBE_EVENTS
	"

	linux-info_pkg_setup
	kernel_is -ge ${MINKV//./ } || die "Kernel version at least ${MINKV} required"
}

src_compile() {
	MODULES_MAKEARGS+=(
		ARCH="x86"
		EXTRA_FLAGS="-fno-stack-protector -fcf-protection"
		KERNEL_DIR="${KV_DIR}"
		KERNEL_HEADERS=/usr # gentoo installs linux-headers to /usr
	)
	emake "${MODULES_MAKEARGS[@]}" -C "$EBPF_DIR" || die
	llvm-strip -g "$EBPF_DIR"/opensnitch*.o
}

src_install(){
	insinto /usr/lib/opensnitchd/ebpf/
	doins "$EBPF_DIR"/opensnitch.o
	doins "$EBPF_DIR"/opensnitch-dns.o
	doins "$EBPF_DIR"/opensnitch-procs.o
}
