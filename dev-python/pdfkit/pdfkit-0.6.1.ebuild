# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Wkhtmltopdf python wrapper"
HOMEPAGE="https://pypi.org/project/pdfkit/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="media-gfx/wkhtmltopdf"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
