# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Headless chrome/chromium automation library "
HOMEPAGE="https://github.com/pyppeteer/pyppeteer https://pypi.org/project/pyppeteer/"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/pyppeteer/pyppeteer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

#__main__.py: error: unrecognized arguments: -n
RESTRICT="test"

RDEPEND="
	>=dev-python/appdirs-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/importlib-metadata-1.4[${PYTHON_USEDEP}]
	>=dev-python/pyee-8.1.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.42.1[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.25.8[${PYTHON_USEDEP}]
	>=dev-python/websockets-10.0[${PYTHON_USEDEP}]
	>=dev-python/certifi-2021[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_prepare(){
	sed -i '/^exclude = \[/,/^\]$/d' pyproject.toml
	eapply_user
}

python_install() {
	distutils-r1_python_install
	find "${ED}" -name README.md -delete
	find "${ED}" -name LICENSE -delete
}
