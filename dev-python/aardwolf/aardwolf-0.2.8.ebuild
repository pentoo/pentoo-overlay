# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous RDP protocol implementation"
HOMEPAGE="https://github.com/skelsec/aardwolf"

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


DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# https://github.com/skelsec/aardwolf/issues/21
QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/librlers.cpython-31.-x86_64-linux-gnu.so"
