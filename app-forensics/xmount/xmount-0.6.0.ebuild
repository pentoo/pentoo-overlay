# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"
SRC_URI="http://files.pinguin.lu/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"

#unable to build, see the upstream bug: https://www.pinguin.lu/node/16
KEYWORDS=""

RDEPEND="sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare(){
	sed -e "s#LIBS = \@LIBS\@#LIBS = \@LIBS\@ -lz#" \
		-i Makefile.in
}

src_configure() {
	use aff || export ac_cv_lib_afflib_af_open=no
	use ewf || export ac_cv_lib_ewf_libewf_open=no
	econf
}
