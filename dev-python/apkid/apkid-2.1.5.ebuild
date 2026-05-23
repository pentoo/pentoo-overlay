# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Android Package Protector Identifier"
HOMEPAGE="https://github.com/rednaga/APKiD/"
# The pypi version use a commit as decompressed name
HASH_COMMIT="009241dad0ea25a9ad64e0c90eda9ad8e2c77032"
S="${WORKDIR}/APKiD-${HASH_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/yara-python[${PYTHON_USEDEP}]
	app-forensics/yara:=[dex]"
DEPEND="${RDEPEND}"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare(){
	#we compile dex
	sed "s|yara-python-dex.*|yara-python',|g" -i setup.py || die
	./prep-release.py
	default
}
