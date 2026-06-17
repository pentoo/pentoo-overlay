# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Extends Selenium webdrv with the request function from the Requests library"
HOMEPAGE="https://github.com/cryzed/Selenium-Requests"
SRC_URI="https://github.com/cryzed/Selenium-Requests/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/Selenium-Requests-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# use gui to test the lib
RESTRICT="test"

RDEPEND="
	>=dev-python/requests-2.26.0[${PYTHON_USEDEP}]
	>=dev-python/selenium-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/tldextract-3.1.1[${PYTHON_USEDEP}]
	<dev-python/requests-3.0.0[${PYTHON_USEDEP}]
	<dev-python/selenium-5.0.0[${PYTHON_USEDEP}]
"
