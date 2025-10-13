# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Decrypting MS Office files with passwords or other keys"
HOMEPAGE="https://github.com/nolze/msoffcrypto-tool"
SRC_URI="https://github.com/nolze/msoffcrypto-tool/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/cryptography-35.0[${PYTHON_USEDEP}]
	>=dev-python/olefile-0.46[${PYTHON_USEDEP}]
"
RESTRICT="test"
