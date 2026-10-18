# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.85.0"

CRATES="
	anstream@0.6.21
	anstyle-parse@0.2.7
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	anyhow@1.0.102
	assert_approx_eq@1.1.0
	bitflags@2.11.1
	cfg-if@1.0.4
	clap@4.4.18
	clap_builder@4.4.18
	clap_lex@0.6.0
	colorchoice@1.0.5
	colored@2.2.0
	crossterm@0.28.1
	crossterm_winapi@0.9.1
	deranged@0.5.8
	errno@0.3.14
	getrandom@0.3.4
	glob@0.3.3
	is_terminal_polyfill@1.70.2
	itoa@1.0.18
	lazy_static@1.5.0
	libc@0.2.185
	linux-raw-sys@0.4.15
	lock_api@0.4.14
	log@0.4.29
	mio@1.2.0
	num-conv@0.1.0
	num_threads@0.1.7
	once_cell_polyfill@1.70.2
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.106
	quote@1.0.45
	r-efi@5.3.0
	rand@0.9.4
	rand_chacha@0.9.0
	rand_core@0.9.5
	redox_syscall@0.5.18
	rustix@0.38.44
	scopeguard@1.2.0
	serde_core@1.0.228
	serde_derive@1.0.228
	signal-hook-mio@0.2.5
	signal-hook-registry@1.4.8
	signal-hook@0.3.18
	simple_logger@4.3.3
	smallvec@1.15.1
	strsim@0.10.0
	syn@2.0.117
	tablestream@0.1.4
	time-core@0.1.7
	time-macros@0.2.25
	time@0.3.45
	unicode-ident@1.0.24
	unicode-truncate@0.2.0
	unicode-width@0.1.14
	utf8parse@0.2.2
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.1+wasi-0.2.4
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.48.0
	windows-sys@0.59.0
	windows-sys@0.61.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	wit-bindgen@0.46.0
	zerocopy-derive@0.8.48
	zerocopy@0.8.48
"

GITHUB_REPOSITORY="trou/cpu_rec_rs"
GITHUB_COMMIT="d09b93cf9e150f408ad0fb568f45a5332fddbc23"

inherit cargo github-archive

DESCRIPTION="Determine which CPU architecture is used in a binary file"

SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+=" BSD MIT MPL-2.0 Unicode-DFS-2016"

SLOT="0"

KEYWORDS="amd64"

QA_FLAGS_IGNORED="usr/bin/cpu_rec_rs"
