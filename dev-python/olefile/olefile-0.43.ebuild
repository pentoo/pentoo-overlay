# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Python package to parse, read and write Microsoft OLE2 files"
HOMEPAGE="https://pypi.python.org/pypi/olefile"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
