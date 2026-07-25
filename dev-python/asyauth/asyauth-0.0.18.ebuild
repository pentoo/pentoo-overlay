# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="asyauth by skilsec"
HOMEPAGE="https://github.com/skelsec/asyauth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	>=dev-python/unicrypto-0.0.10[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.11[${PYTHON_USEDEP}]
	>=dev-python/minikerberos-0.4.4[${PYTHON_USEDEP}]
"
