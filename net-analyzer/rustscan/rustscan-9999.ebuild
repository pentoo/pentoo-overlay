# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
ansi_term-0.11.0
async-channel-1.1.1
async-std-1.6.2
async-task-3.0.0
atomic-waker-1.0.0
atty-0.2.14
autocfg-1.0.0
bitflags-1.2.1
blocking-0.4.7
bumpalo-3.4.0
cache-padded-1.1.1
cc-1.0.58
cfg-if-0.1.10
clap-2.33.1
colored-1.9.3
concurrent-queue-1.1.2
crossbeam-utils-0.7.2
event-listener-2.2.1
fastrand-1.3.3
futures-0.3.5
futures-channel-0.3.5
futures-core-0.3.5
futures-executor-0.3.5
futures-io-0.3.5
futures-lite-0.1.9
futures-macro-0.3.5
futures-sink-0.3.5
futures-task-0.3.5
futures-util-0.3.5
hermit-abi-0.1.15
js-sys-0.3.42
kv-log-macro-1.0.7
lazy_static-1.4.0
libc-0.2.73
log-0.4.11
memchr-2.3.3
num_cpus-1.13.0
once_cell-1.4.0
parking-1.0.6
pin-project-0.4.22
pin-project-internal-0.4.22
pin-project-lite-0.1.7
pin-utils-0.1.0
proc-macro-hack-0.5.16
proc-macro-nested-0.1.6
proc-macro2-1.0.19
quote-1.0.7
redox_syscall-0.1.57
rlimit-0.3.0
rustscan-1.2.0
scoped-tls-1.0.0
slab-0.4.2
smol-0.1.18
socket2-0.3.12
strsim-0.8.0
syn-1.0.35
textwrap-0.11.0
unicode-width-0.1.8
unicode-xid-0.2.1
vec_map-0.8.2
waker-fn-1.0.0
wasm-bindgen-0.2.65
wasm-bindgen-backend-0.2.65
wasm-bindgen-futures-0.4.15
wasm-bindgen-macro-0.2.65
wasm-bindgen-macro-support-0.2.65
wasm-bindgen-shared-0.2.65
web-sys-0.3.42
wepoll-sys-stjepang-1.0.6
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo

DESCRIPTION="Faster Nmap Scanning with Rust"
HOMEPAGE="https://github.com/brandonskerritt/RustScan"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/brandonskerritt/RustScan"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/brandonskerritt/RustScan/archive/${PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris ${CRATES})"

	S="${WORKDIR}/RustScan-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RESTRICT="mirror"

BDEPEND="virtual/rust"

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	dobin target/release/rustscan
	dodoc -r *.md
}
