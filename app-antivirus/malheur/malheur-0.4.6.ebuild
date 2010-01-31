# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="malware analysis tool"
HOMEPAGE="http://www.mlsec.org/malheur/"
SRC_URI="http://www.mlsec.org/malheur/files/$PN-$PV.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="openmp"

DEPEND=""
RDEPEND=">=dev-libs/libconfig-1.3.2
		 >=app-arch/libarchive-2.7.0
		 openmp? ( sys-devel/gcc[openmp] )"

src_configure() {
	econf\
		$(use_enable openmp)
	# we also have optional matlab support, but thats proprietary afaik
}
src_install() {
	DESTDIR="${D}" emake install || die "install failed"
}
