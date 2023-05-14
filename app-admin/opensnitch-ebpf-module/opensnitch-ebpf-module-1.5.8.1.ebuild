# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="eBPF process monitor module for opensnitch"
HOMEPAGE="https://github.com/evilsocket/opensnitch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# latest kernel that builds: 6.0.14
_KV_MAJOR=6
_KV_MINOR=0
_KV_PATCH=14

SRC_URI="
	https://github.com/evilsocket/opensnitch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://cdn.kernel.org/pub/linux/kernel/v${_KV_MAJOR}.x/linux-${_KV_MAJOR}.${_KV_MINOR}.${_KV_PATCH}.tar.gz
"

S="${WORKDIR}/linux-${_KV_MAJOR}.${_KV_MINOR}.${_KV_PATCH}"
_BPF_S="${WORKDIR}/opensnitch-${PV}/ebpf_prog"
_KERNEL_BPF_PATH=samples/bpf

BDEPEND="
	sys-devel/bc
	sys-devel/clang
	sys-devel/llvm
	net-misc/rsync
"

RESTRICT="strip test"
QA_PREBUILT="*"

PATCHES=(
	"${_BPF_S}/file.patch"
)

# see https://github.com/evilsocket/opensnitch/issues/774
# and https://github.com/evilsocket/opensnitch/tree/master/ebpf_prog
CONFIG_CHECK="
	DEBUG_FS
	FTRACE
	CGROUP_BPF
	BPF
	BPF_SYSCALL
	BPF_EVENTS
	KPROBES
	KPROBES_ON_FTRACE
	HAVE_KPROBES
	HAVE_KPROBES_ON_FTRACE
	KPROBE_EVENTS
	HAVE_SYSCALL_TRACEPOINTS
	FTRACE_SYSCALLS
	UPROBE_EVENTS
"

pkg_pretend() {
	linux-info_pkg_setup
}

src_prepare() {
	default
	local MY_SRC=(
		"${_BPF_S}/opensnitch.c"
		"${_BPF_S}/Makefile"
	)
	cp "${MY_SRC[@]}" "${_KERNEL_BPF_PATH}" || die
}

src_configure() {
	set_arch_to_kernel
	yes "" | make oldconfig
	emake prepare
}

src_compile() {
	emake headers_install

	emake -C "${_KERNEL_BPF_PATH}"

	llvm-strip -g "${_KERNEL_BPF_PATH}"/opensnitch.o
}

src_install(){
	insinto /etc/opensnitchd
	doins "${_KERNEL_BPF_PATH}"/opensnitch.o
}
