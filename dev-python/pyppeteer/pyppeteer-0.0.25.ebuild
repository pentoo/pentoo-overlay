# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Headless chrome/chromium automation library "
HOMEPAGE="https://github.com/pyppeteer/pyppeteer https://pypi.org/project/pyppeteer/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
# KEYWORDS="~amd64 ~x86"  # Requires dev-python/pyee, but is not in Gentoo, nor Pentoo
IUSE="test"

RDEPEND="
	<dev-python/pyee-8[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	<dev-python/urllib3-1.25[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
