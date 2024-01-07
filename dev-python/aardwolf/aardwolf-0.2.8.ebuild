# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

CRATES="
	autocfg@1.1.0
	bitflags@1.3.2
	byteorder@1.4.3
	cfg-if@1.0.0
	derivative@2.2.0
	indoc@1.0.7
	lazy_static@1.4.0
	libc@0.2.134
	lock_api@0.4.9
	num_enum@0.4.3
	num_enum_derive@0.4.3
	once_cell@1.15.0
	parking_lot@0.12.1
	parking_lot_core@0.9.3
	proc-macro-crate@0.1.5
	proc-macro2@1.0.46
	pyo3-build-config@0.16.6
	pyo3-ffi@0.16.6
	pyo3-macros-backend@0.16.6
	pyo3-macros@0.16.6
	pyo3@0.16.6
	quote@1.0.21
	redox_syscall@0.2.16
	scopeguard@1.1.0
	serde@1.0.145
	smallvec@1.10.0
	syn@1.0.102
	target-lexicon@0.12.4
	toml@0.5.9
	unicode-ident@1.0.5
	unindent@0.1.10
	windows-sys@0.36.1
	windows_aarch64_msvc@0.36.1
	windows_i686_gnu@0.36.1
	windows_i686_msvc@0.36.1
	windows_x86_64_gnu@0.36.1
	windows_x86_64_msvc@0.36.1
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Asynchronous RDP protocol implementation"
HOMEPAGE="https://github.com/skelsec/aardwolf"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	>=dev-python/unicrypto-0.0.10[${PYTHON_USEDEP}]
	>=dev-python/asyauth-0.0.16[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.9[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/asn1tools[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/arc4-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-9.0.0[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
	virtual/rust
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# https://github.com/skelsec/aardwolf/issues/21
# Rust does not respect CFLAGS/LDFLAGS
QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/librlers.cpython-31.-x86_64-linux-gnu.so
.*/_rust.*
"

src_unpack() {
	cargo_src_unpack
}
