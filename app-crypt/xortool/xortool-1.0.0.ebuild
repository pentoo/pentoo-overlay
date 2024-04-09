# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A tool to analyze multi-byte xor cipher"
HOMEPAGE="https://github.com/hellman/xortool"
SRC_URI="https://github.com/hellman/xortool/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

#BDEPEND="dev-python/wheel[${PYTHON_USEDEP}]"
RDEPEND="${PYTHON_DEPS}
	dev-python/docopt[${PYTHON_USEDEP}]"
