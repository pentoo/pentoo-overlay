# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
DISTUTILS_USE_SETUPTOOLS=no
inherit distutils-r1

DESCRIPTION="a python library which helps in using nmap port scanner"
HOMEPAGE="https://xael.org/pages/python-nmap-en.html"
SRC_URI="mirror://pypi/p/python-nmap/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 arm64 x86"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#PYTHON_MODNAME="nmap"
