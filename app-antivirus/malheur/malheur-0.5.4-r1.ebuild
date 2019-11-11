# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Malware analysis tool"
HOMEPAGE="https://github.com/rieck/malheur"
SRC_URI="https://github.com/rieck/malheur/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="openmp"

DEPEND=""
RDEPEND="
	app-arch/libarchive:*
	dev-libs/libconfig:*
	dev-libs/uthash
	openmp? ( sys-devel/gcc[openmp] )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf $(use_enable openmp)
}

src_install() {
	default
	keepdir /var/lib/malheur
}
