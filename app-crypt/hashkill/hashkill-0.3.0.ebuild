# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="http://www.gat3way.eu/hashkill"
HOMEPAGE="Multi-threaded password recovery tool with multi-GPU support"
SRC_URI="https://github.com/downloads/gat3way/hashkill/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opencl-sdk"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's#/usr#${ED}/usr#' src/kernels/Makefile
	sed -i 's#/usr#${ED}/usr#' src/plugins/Makefile
	sed -i 's#/usr#${ED}/usr#' src/markov/Makefile
}

#src_configure() {
#	econf --prefix="${ED}/usr"
#}
