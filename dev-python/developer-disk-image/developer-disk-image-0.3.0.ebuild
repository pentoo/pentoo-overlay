# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO=https://github.com/doronz88/DeveloperDiskImage

inherit distutils-r1 pypi

DESCRIPTION="Download DeveloperDiskImage ans Personalized images from GitHub"
HOMEPAGE="https://github.com/doronz88/DeveloperDiskImage"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
# the tests shall have a github token to download files
RESTRICT="test"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
