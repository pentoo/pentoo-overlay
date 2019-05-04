# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )
inherit distutils-r1

DESCRIPTION="A hierarchical, easy-to-use, powerful configuration module for Python"
HOMEPAGE="http://www.red-dove.com/python_config.html"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
