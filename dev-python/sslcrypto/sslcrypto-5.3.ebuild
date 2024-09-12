# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="ECIES, AES and RSA OpenSSL-based implementation with fallback"
HOMEPAGE="
	https://pypi.org/project/sslcrypto/
"

LICENSE="MIT BSD-2"
SLOT="0"
KEYWORDS="~amd64"

#Missing some files in test/ ?
RESTRICT="test"

DEPEND="dev-python/base58
	dev-python/pyaes
"
RDEPEND="${RDPEND}"

distutils_enable_tests pytest

src_prepare() {
	#ends up stray and doesn't work anyway due to missing files
	rm -rf "${S}/test"
	distutils-r1_src_prepare
}
