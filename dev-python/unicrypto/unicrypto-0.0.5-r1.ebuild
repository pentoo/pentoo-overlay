# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Unified interface for cryptographic libraries"
HOMEPAGE="https://github.com/skelsec/unicrypto"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND="dev-python/pycryptodome[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests pytest

src_prepare() {
	#https://github.com/skelsec/unicrypto/issues/2
	#force pycryptodome backend
	sed -i -e "s|override_library = None|override_library = \'Crypto\'|" unicrypto/__init__.py || die
	#override_library = 'cryptography' for dev-python/cryptography
	#override_library = 'mbedtls' for net-libs/mbedtls
	eapply_user
}
