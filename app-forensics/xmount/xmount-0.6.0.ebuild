# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"
SRC_URI="http://files.pinguin.lu/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="aff ewf"

#unable to build, see the upstream bug: https://www.pinguin.lu/node/16
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}
	sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"

src_prepare(){
	sed -e "s#LIBS = \@LIBS\@#LIBS = \@LIBS\@ -lz#" \
		-i Makefile.in
}

#src_configure() {
#	make all LIB* optional
#	WITH_LIBAAFF WITH_LIBEWF WITH_LIBAFF
#}
