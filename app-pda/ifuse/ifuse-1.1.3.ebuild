# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/ifuse/ifuse-1.1.2-r1.ebuild,v 1.3 2014/03/03 23:56:08 pacho Exp $

EAPI=5
inherit autotools readme.gentoo

DESCRIPTION="Mount Apple iPhone/iPod Touch file systems for backup purposes"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.1.4:=
	>=app-pda/libplist-1.8:=
	>=sys-fs/fuse-2.7.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README"

DOC_CONTENTS="Only use this filesystem driver to create backups of your data.
The music database is hashed, and attempting to add files will cause the
iPod/iPhone to consider your database unauthorised.
It will respond by wiping all media files, requiring a restore through iTunes."

#src_prepare() {
#	epatch "${FILESDIR}"/${P}-libimobiledevice115.patch
#	eautoreconf
#}
