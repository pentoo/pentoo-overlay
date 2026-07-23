# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

# cd aardwolf/utils/rlers
# cargo build
# pycargoebuild ./
CRATES="
	autocfg@1.4.0
	byteorder@1.5.0
	heck@0.5.0
	indoc@2.0.6
	libc@0.2.171
	memoffset@0.9.1
	once_cell@1.21.1
	portable-atomic@1.11.0
	proc-macro2@1.0.94
	pyo3-build-config@0.27.2
	pyo3-ffi@0.27.2
	pyo3-macros-backend@0.27.2
	pyo3-macros@0.27.2
	pyo3@0.27.2
	quote@1.0.40
	syn@2.0.100
	target-lexicon@0.13.4
	unicode-ident@1.0.18
	unindent@0.2.4
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Asynchronous RDP protocol implementation"
HOMEPAGE="https://github.com/skelsec/aardwolf"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/unicrypto-0.0.11[${PYTHON_USEDEP}]
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
	${RDEPEND}
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
"

# https://github.com/skelsec/aardwolf/issues/21
# Rust does not respect CFLAGS/LDFLAGS
QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/librlers.cpython-31.-x86_64-linux-gnu.so"
