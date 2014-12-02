# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python binding of libnetfilter_conntrack"
HOMEPAGE="https://pypi.python.org/pypi/pynetfilter_conntrack"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="net-libs/libnetfilter_conntrack
	dev-python/ipy"
DEPEND="${DEPEND}"

src_prepare(){
	sed -e 's|libnetfilter_conntrack.so.1|libnetfilter_conntrack.so|' -i pynetfilter_conntrack/func.py || die "sed failed"
}
