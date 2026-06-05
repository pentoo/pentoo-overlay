# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Extends Selenium webdrv with the request function from the Requests library"
HOMEPAGE="https://github.com/cryzed/Selenium-Requests"
SRC_URI="https://github.com/cryzed/Selenium-Requests/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/Selenium-Requests-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/selenium[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]
"
