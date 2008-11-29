# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.4

inherit distutils

MY_PV=${PV/_/}

DESCRIPTION="Fusil the fuzzer is a Python library used to write fuzzing programs"
HOMEPAGE="http://fusil.hachoir.org/"
SRC_URI="http://pypi.python.org/packages/source/f/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/python-ptrace-0.4.2
	dev-python/ctypes
	dev-python/python-xlib"

S="${WORKDIR}/${PN}-${MY_PV}"

PYTHON_MODNAME="fusil"
