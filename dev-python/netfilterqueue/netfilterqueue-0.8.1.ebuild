# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

MY_PN=NetfilterQueue
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python bindings for libnetfilter_queue"
HOMEPAGE="https://pypi.python.org/pypi/NetfilterQueue"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libnetfilter_queue"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
