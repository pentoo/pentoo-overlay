# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="eBPF process monitor module for opensnitch"
HOMEPAGE="https://github.com/evilsocket/opensnitch"
SRC_URI="
	https://github.com/evilsocket/opensnitch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/opensnitch-${PV}"
EBPF_DIR=ebpf_prog

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"
BDEPEND="
	sys-devel/bc
	sys-devel/clang
	sys-devel/llvm
	net-misc/rsync
	sys-kernel/linux-headers
"

RESTRICT="strip test"
QA_PREBUILT="*"

CONFIG_CHECK="
	CGROUP_BPF
	BPF
	BPF_SYSCALL
	BPF_EVENTS
	KPROBES
	KPROBE_EVENTS
"

pkg_pretend() {
	linux-info_pkg_setup
	kernel_is -ge 5 5 || die # only compatible with kernels >= 5.5
}

src_compile() {
	MODULES_MAKEARGS+=(
		ARCH="x86"
		EXTRA_FLAGS="-fno-stack-protector -fcf-protection"
		KERNEL_DIR="$KERNEL_DIR"
	)
	emake "${MODULES_MAKEARGS[@]}" -C "$EBPF_DIR" || die
	llvm-strip -g "$EBPF_DIR"/opensnitch.o
}

src_install(){
	insinto /usr/lib/opensnitchd/ebpf/
	doins "$EBPF_DIR"/opensnitch.o
}
