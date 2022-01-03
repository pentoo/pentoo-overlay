# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="A tool to analyze multi-byte xor cipher"
HOMEPAGE="https://github.com/hellman/xortool"
SRC_URI="https://github.com/hellman/xortool/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-python/wheel[${PYTHON_USEDEP}]"
RDEPEND="${PYTHON_DEPS}
	dev-python/docopt[${PYTHON_USEDEP}]"
