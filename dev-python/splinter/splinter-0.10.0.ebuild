# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="tool for testing web applications"
HOMEPAGE="https://github.com/cobrateam/splinter"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
#SRC_URI="https://github.com/cobrateam/python-htmlentities/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/selenium-3.141.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"


#    extras_require={
#        "zope.testbrowser": ["zope.testbrowser>=5.2.4", "lxml>=4.2.4", "cssselect"],
#        "django": ["Django>=1.7.11;python_version<'3.0'", "Django>=2.0.6;python_version>'3.3'", "lxml>=2.3.6", "cs
#        "flask": ["Flask>=1.0.2", "lxml>=2.3.6", "cssselect"],
#    },
