# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Malware analysis tool"
HOMEPAGE="http://www.mlsec.org/malheur/"
SRC_URI="http://www.mlsec.org/malheur/files/$PN-$PV.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="openmp"

DEPEND=""
RDEPEND=">=dev-libs/libconfig-1.3.2
	>=app-arch/libarchive-3.0.4
	dev-libs/uthash
	openmp? ( sys-devel/gcc[openmp] )"

src_configure() {
	econf\
		$(use_enable openmp)
}
