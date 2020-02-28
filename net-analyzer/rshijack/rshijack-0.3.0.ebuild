# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.6.4
ansi_term-0.11.0
arrayref-0.3.4
atty-0.2.8
backtrace-0.3.5
backtrace-sys-0.1.16
bitflags-0.5.0
bitflags-1.0.1
cc-1.0.8
cfg-if-0.1.2
clap-2.31.2
env_logger-0.5.6
error-chain-0.11.0
glob-0.2.11
humantime-1.1.1
ipnetwork-0.12.8
kernel32-sys-0.2.2
lazy_static-1.0.0
libc-0.2.39
log-0.3.9
log-0.4.1
memchr-1.0.2
memchr-2.0.1
nom-3.2.1
pktparse-0.2.2
pnet-0.21.0
pnet_base-0.21.0
pnet_datalink-0.21.0
pnet_macros-0.21.0
pnet_macros_support-0.21.0
pnet_packet-0.21.0
pnet_sys-0.21.0
pnet_transport-0.21.0
quick-error-1.2.1
redox_syscall-0.1.37
redox_termios-0.1.1
regex-0.2.10
regex-syntax-0.5.3
rshijack-0.3.0
rustc-demangle-0.1.7
rustc-serialize-0.3.24
strsim-0.7.0
syntex-0.42.2
syntex_errors-0.42.0
syntex_pos-0.42.0
syntex_syntax-0.42.0
term-0.4.6
termcolor-0.3.5
termion-1.5.1
textwrap-0.9.0
thread_local-0.3.5
ucd-util-0.1.1
unicode-width-0.1.4
unicode-xid-0.0.3
unreachable-1.0.0
utf8-ranges-1.0.0
vec_map-0.8.0
void-1.0.2
winapi-0.2.8
winapi-0.3.4
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
wincolor-0.1.6
ws2_32-sys-0.2.1
"

inherit cargo

DESCRIPTION="A tcp connection hijacker, rust rewrite of shijack"
HOMEPAGE="https://github.com/kpcyrd/rshijack"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RESTRICT="mirror"

DOCS=( README.md Dockerfile )
