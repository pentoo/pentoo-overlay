# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

GITHUB_REPOSITORY="shenril/Sitadel"
GITHUB_COMMIT="9e544326225f976b861f0a454d8e1c4647c34998"
inherit distutils-r1 github-archive

DESCRIPTION="Web application security scanner"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/Scrapy[${PYTHON_USEDEP}]"
