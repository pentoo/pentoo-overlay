# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Android Package Protector Identifier"
HOMEPAGE="https://github.com/rednaga/APKiD/"
#Use github to download a version with ./prep-release.py script which compiles yara rules
HASH_COMMIT="a50ee3b4a42a3e1a284af9eafa79e41ee80bc59f"
SRC_URI="https://github.com/rednaga/APKiD/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""
RESTRICT="test"

RDEPEND="${PYTHON_DEPS}
	dev-python/yara-python[${PYTHON_USEDEP}]
	app-forensics/yara:=[dex]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/APKiD-${HASH_COMMIT}"

src_prepare(){
	#we compile dex
	sed "s|yara-python-dex.*|yara-python',|g" -i setup.py || die
	./prep-release.py
	default
}
