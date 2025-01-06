# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} pypy3 )

inherit pypi distutils-r1

DESCRIPTION="Dynamic versioning library and CLI"
HOMEPAGE="
	https://pypi.org/project/dunamai/
	https://github.com/mtkennerly/dunamai
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
