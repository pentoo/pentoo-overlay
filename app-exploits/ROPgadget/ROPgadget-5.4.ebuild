# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Tool to search for gadgets in binaries to facilitate your ROP exploitation"
HOMEPAGE="http://shell-storm.org/project/ROPgadget/"
SRC_URI="https://github.com/JonathanSalwan/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/capstone-python[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

