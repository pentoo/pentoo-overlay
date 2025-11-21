# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="APIs to easily crawl the Google Play Store for Python"
HOMEPAGE="https://github.com/JoMingyu/google-play-scraper"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

# need network
RESTRICT="test"
