# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://www.gat3way.eu/hashkill/${P}.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's#/usr#${ED}/usr#' src/kernels/Makefile
	sed -i 's#/usr#${ED}/usr#' src/plugins/Makefile
	sed -i 's#/usr#${ED}/usr#' src/markov/Makefile
}

#src_configure() {
#	econf --prefix="${ED}/usr"
#}
