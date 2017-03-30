#Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit git-r3 distutils-r1

DESCRIPTION="Wordpress finger printing tool, retrieve information about the plugins and versions installed"
HOMEPAGE="http://www.iniqua.com/labs/plecost/"

EGIT_REPO_URI="https://github.com/iniqua/plecost.git"
EGIT_BRANCH="develop"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/beautifulsoup[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/termcolor[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
