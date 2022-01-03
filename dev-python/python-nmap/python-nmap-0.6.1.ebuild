# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="a python library which helps in using nmap port scanner"
HOMEPAGE="https://xael.org/norman/python/python-nmap/"
SRC_URI="mirror://pypi/p/python-nmap/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"

#PYTHON_MODNAME="nmap"
