# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $
 
NEED_PYTHON=2.4
 
inherit distutils
 
DESCRIPTION="python-ptrace is a debugger using ptrace (Linux, BSD and Darwin system call to trace processes) written in Python."
HOMEPAGE="http://python-ptrace.hachoir.org/"
SRC_URI="http://pypi.python.org/packages/source/p/python-ptrace/${P}.tar.gz"
 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
 
DEPEND="|| ( ( =dev-lang/python-2.4* dev-python/ctypes ) >=dev-lang/python-2.5 )"
RDEPEND="dev-libs/distorm"
 
PYTHON_MODNAME="ptrace"
