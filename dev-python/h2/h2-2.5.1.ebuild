# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Hyper: HTTP/2 Client for Python"
HOMEPAGE="https://pypi.python.org/pypi/h2"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/enum34-1.0.4 <dev-python/enum34-2
	>=dev-python/hpack-2.2 <dev-python/hpack-3
	>=dev-python/hyperframe-3.1 <dev-python/hyperframe-5
	!=dev-python/hyperframe-4.0.0
	"
