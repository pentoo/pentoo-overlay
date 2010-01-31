# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit distutils

DESCRIPTION="a debugger using ptrace (Linux, BSD and Darwin system call to trace processes) written in Python."
HOMEPAGE="http://bitbucket.org/haypo/python-ptrace/wiki/Home"
SRC_URI="http://pypi.python.org/packages/source/p/python-ptrace/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="|| ( ( =dev-lang/python-2.4* dev-python/ctypes ) >=dev-lang/python-2.5 )"
RDEPEND="dev-libs/distorm"

PYTHON_MODNAME="ptrace"
