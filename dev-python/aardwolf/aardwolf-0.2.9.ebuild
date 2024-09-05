# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#CARGO_OPTIONAL=1
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

# cd aardwolf/utils/rlers
# cargo build
# pycargoebuild ./
CRATES="
	autocfg@1.3.0
	bitflags@2.6.0
	byteorder@1.5.0
	cfg-if@1.0.0
	derivative@2.2.0
	indoc@1.0.9
	lazy_static@1.5.0
	libc@0.2.158
	lock_api@0.4.12
	num_enum@0.4.3
	num_enum_derive@0.4.3
	once_cell@1.19.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	proc-macro-crate@0.1.5
	proc-macro2@1.0.86
	pyo3-build-config@0.16.6
	pyo3-ffi@0.16.6
	pyo3-macros-backend@0.16.6
	pyo3-macros@0.16.6
	pyo3@0.16.6
	quote@1.0.37
	redox_syscall@0.5.3
	scopeguard@1.2.0
	serde@1.0.209
	serde_derive@1.0.209
	smallvec@1.13.2
	syn@1.0.109
	syn@2.0.77
	target-lexicon@0.12.16
	toml@0.5.11
	unicode-ident@1.0.12
	unindent@0.1.11
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
"

inherit cargo distutils-r1
# pypi

DESCRIPTION="Asynchronous RDP protocol implementation"
HOMEPAGE="https://github.com/skelsec/aardwolf"
SRC_URI="https://github.com/skelsec/aardwolf/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
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

#https://github.com/skelsec/aardwolf/issues/29
python_install() {
	rm -r ${PN}/utils/rlers
	distutils-r1_python_install
#	python_moduleinto aardwolf
	python_domodule aardwolf
}
