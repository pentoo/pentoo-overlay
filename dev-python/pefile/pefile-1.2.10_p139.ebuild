# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
MY_P=${P/_p/-}

inherit distutils-r1

DESCRIPTION="Module to read and work with Portable Executable (PE) files"
HOMEPAGE="https://github.com/erocarrera/pefile"
SRC_URI="https://github.com/erocarrera/pefile/archive/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}/${MY_P}"
