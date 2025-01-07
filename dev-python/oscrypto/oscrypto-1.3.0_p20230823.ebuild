# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

# fix https://github.com/wbond/oscrypto/issues/78
HASH_COMMIT="1547f535001ba568b239b8797465536759c742a3"

DESCRIPTION="TLS sockets, key generation, encryption, decryption, signing, verification"
HOMEPAGE="https://github.com/wbond/oscrypto"
SRC_URI="https://github.com/wbond/oscrypto/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

#not tested
RESTRICT="test"

RDEPEND="	>=dev-python/asn1crypto-1.5.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
