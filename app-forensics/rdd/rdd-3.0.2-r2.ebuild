# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/rdd/rdd-2.0.7.ebuild,v 1.2 2009/09/11 11:22:05 flameeyes Exp $

EAPI="4"

DESCRIPTION="Rdd is a forensic copy program"
HOMEPAGE="http://www.sf.net/projects/rdd"
SRC_URI="mirror://sourceforge/rdd/rdd-${PV}.tar.gz"

KEYWORDS="~x86 ~amd64"
IUSE="debug"
LICENSE="BSD"
SLOT="0"

#GUI is broken, see upstream https://sourceforge.net/tracker/?func=detail&atid=837482&aid=3112605&group_id=165965

#DEPEND="gtk? (	>=x11-libs/gtk+-2
#		>=gnome-base/libglade-2 )"

DEPEND="|| ( app-forensics/libewf[ewf2] >=app-forensics/libewf-20110801 )
	app-forensics/libbfio"
RDEPEND="${DEPEND}"

#src_prepare() {
#	use gtk || sed -i 's/AM_PATH_GTK_2_0//' configure.ac
#	eautoreconf
#}

src_configure() {
#		$(use_enable gtk gui)\
	econf $(use_enable debug tracing)
}

src_compile() {
	emake -j1
}

src_install() {
	# emake install has a sandbox violation in src/Makefile
	dobin src/rdd-copy
	dobin src/rdd-verify
	dobin src/rddi.py
	doman src/*.1
	dosym rdd-copy /usr/bin/rdd
	dosym rddi.py /usr/bin/rddi
}
