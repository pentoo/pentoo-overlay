# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Steganography brute-force utility to uncover hidden data inside files"
HOMEPAGE="https://github.com/Paradoxis/StegCracker"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="2"

RDEPEND="${PYTHON_DEPS}
	app-crypt/steghide"
