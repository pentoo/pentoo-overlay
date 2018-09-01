Close
# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_6 ,3_7} ) # 3.5 3.4 also posible
inherit distutils-r1

DESCRIPTION="Python interface for a malware identification and classification tool"
HOMEPAGE="http://www.py2exe.org/"
# svn://svn.code.sf.net/p/py2exe/svn/trunk py2exe-svn
mirror://sourceforge/py2exe/${PN}/source/${MY_P}.zip"
# NOTE: Using Py2Exe is recommended over PyInstaller (as it has a lower detection rate). for veil 3.x 
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

DEPEND=">=dev-lang/python-2.3
dev-libs/cygwin
sys-libs/cygwin-crypt
#https://github.com/4nykey/4nykey overlay.. 
# else /mingw32/64-runtime
#app-wine/python-winbuilder::raiagent 
#(cross-x86_64-pc-cygwin/cygwin || cross-x86_64-w64-mingw32/mingw64-runtime)
#cross-x86_64-pc-cygwin/w32api"
# (dev-util/mingw-runtime::gentoo || dev-util/mingw64-runtime::gentoo)
RDEPEND="${DEPEND}"