# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous SMB protocol implementation"
HOMEPAGE="https://github.com/skelsec/aiosmb"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	>=dev-python/unicrypto-0.0.10[${PYTHON_USEDEP}]
	>=dev-python/asyauth-0.0.16[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.9[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3.0.2[${PYTHON_USEDEP}]
	>=dev-python/winacl-0.1.8[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
