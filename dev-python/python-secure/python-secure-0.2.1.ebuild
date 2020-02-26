# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
MY_PN="${PN#python-}"

inherit distutils-r1

DESCRIPTION="Secure headers and cookies for Python web frameworks"
HOMEPAGE="https://github.com/TypeError/secure.py"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	virtual/python-enum34[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_PN}-${PV}"
