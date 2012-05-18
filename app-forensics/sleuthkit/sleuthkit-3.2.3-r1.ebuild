# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/sleuthkit/sleuthkit-3.2.3.ebuild,v 1.2 2012/02/28 02:29:54 radhermit Exp $

EAPI="4"
AUTOTOOLS_AUTORECONF=1

inherit eutils autotools-utils

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz mirror://sourceforge/project/libewf/patches%20for%203rd%20party%20software/sleuthkit/tsk3.2.3-libewf.patch"

LICENSE="GPL-2 IBM"
SLOT=0
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="aff ewf static-libs"

DEPEND="dev-db/sqlite:3
	ewf? ( >=app-forensics/libewf-20120416 )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND}
	dev-perl/DateManip"

DOCS=( NEWS.txt README.txt )

PATCHES=(
	"${FILESDIR}"/${P}-system-sqlite.patch
	"${FILESDIR}"/${P}-tools-shared-libs.patch
	"${DISTDIR}"/tsk${PV}-libewf.patch
)

src_configure() {
	local myeconfargs=(
		$(use_with aff afflib)
		$(use_with ewf libewf)
	)
	autotools-utils_src_configure
}
