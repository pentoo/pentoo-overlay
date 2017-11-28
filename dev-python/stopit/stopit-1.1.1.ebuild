# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Timeout control decorator and context managers"
HOMEPAGE="https://pypi.python.org/pypi/stopit"
SRC_URI="mirror://pypi/s/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
