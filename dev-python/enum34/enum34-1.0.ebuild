# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Python 3.4 Enum backported to 3.3, 3.2, 3.1, 2.7, 2.6, 2.5 and 2.4"
HOMEPAGE="https://pypi.python.org/pypi/enum34"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
