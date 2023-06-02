# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="asyauth by skilsec"
HOMEPAGE="https://github.com/skelsec/asyauth"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND="
	>=dev-python/unicrypto-0.0.10[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.7[${PYTHON_USEDEP}]
	>=dev-python/minikerberos-0.4.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests pytest
