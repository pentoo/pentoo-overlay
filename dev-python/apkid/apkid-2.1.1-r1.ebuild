# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Android Package Protector Identifier"
HOMEPAGE="https://github.com/rednaga/APKiD/"
#Use github to download a version with ./prep-release.py script which compiles yara rules
SRC_URI="https://github.com/rednaga/APKiD/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

RDEPEND="${PYTHON_DEPS}
	dev-python/yara-python[dex,${PYTHON_USEDEP}]
	app-forensics/yara:="
DEPEND="${RDEPEND}"

S="${WORKDIR}/APKiD-${PV}"

src_prepare(){
	#relax yara and regenarate rules for the current version
	sed "s|yara-python==3.11.0|yara-python>=3.11.0|g" -i setup.py || die
	./prep-release.py
	default
}
