# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="a python library which helps in using nmap port scanner"
HOMEPAGE="http://xael.org/norman/python/python-nmap/"
SRC_URI="mirror://pypi/p/python-nmap/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

#PYTHON_MODNAME="nmap"
