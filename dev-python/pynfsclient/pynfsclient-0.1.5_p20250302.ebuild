# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

HASH_COMMIT="db23219a1aed79a51a5d6a0a32635a3ba887221e"

DESCRIPTION="A library to simulate NFS client"
HOMEPAGE="https://github.com/Pennyw0rth/NfsClient"
SRC_URI="https://github.com/Pennyw0rth/NfsClient/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/NfsClient-${HASH_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

#not tested
RESTRICT="test"

#RDEPEND=">=dev-python/asn1crypto-1.5.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

