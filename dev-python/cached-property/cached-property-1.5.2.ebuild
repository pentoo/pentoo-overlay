# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="A cached-property for decorating methods in classes"
HOMEPAGE="https://github.com/pydanny/cached-property"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"

BDEPEND="test? ( dev-python/freezegun[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

DOCS=( {HISTORY,README}.rst )

PATCHES=(
	# bug 638250
	"${FILESDIR}"/${PN}-1.5.1-test-failure.patch
	# @asyncio.coroutine removed in py3.11
	"${FILESDIR}"/${PN}-1.5.2-python311.patch
)
