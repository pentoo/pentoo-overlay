# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Extends Selenium webdrv classes to include the request function from the Requests library"
HOMEPAGE="https://github.com/cryzed/Selenium-Requests"
SRC_URI="https://github.com/cryzed/Selenium-Requests/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/selenium[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]"

S="${WORKDIR}/Selenium-Requests-${PV}"
