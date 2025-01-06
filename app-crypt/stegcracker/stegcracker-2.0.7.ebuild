# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Steganography brute-force utility to uncover hidden data inside files"
HOMEPAGE="https://github.com/Paradoxis/StegCracker"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="2"

RDEPEND="${PYTHON_DEPS}
	app-crypt/steghide"
