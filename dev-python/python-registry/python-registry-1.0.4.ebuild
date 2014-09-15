# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A pure Python module that provides read access to Windows Registry files"
HOMEPAGE="http://www.williballenthin.com/registry/"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/enum34"
