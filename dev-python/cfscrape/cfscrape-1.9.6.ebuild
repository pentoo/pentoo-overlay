# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Python client library for Core API"
HOMEPAGE="https://github.com/Anorov/cloudflare-scrape"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
#	dev-python/setuptools[${PYTHON_USEDEP}]
#	"
#	test? ( dev-python/mock[${PYTHON_USEDEP}]
#	)"
