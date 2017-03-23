# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils

DESCRIPTION="ntop-maintained superset of the popular OpenDPI library"
HOMEPAGE="http://www.ntop.org/products/ndpi/"
SRC_URI="https://github.com/ntop/nDPI/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/nDPI-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.0-system.patch
	eautoreconf
	default
}
