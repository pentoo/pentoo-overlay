# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Python library for reading and writing Windows shortcut files"
HOMEPAGE="https://sourceforge.net/projects/pylnk/"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
#SRC_URI="https://github.com/cobrateam/python-htmlentities/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

#S="${WORKDIR}/python-${P}"
