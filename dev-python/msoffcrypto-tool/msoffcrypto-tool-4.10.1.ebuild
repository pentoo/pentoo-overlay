# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python tool & library for decrypting MS Office files with passwords or other keys"
HOMEPAGE="https://github.com/nolze/msoffcrypto-tool"
SRC_URI="https://github.com/nolze/msoffcrypto-tool/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/olefile[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]"
