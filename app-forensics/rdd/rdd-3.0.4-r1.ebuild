# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/rdd/rdd-3.0.4.ebuild,v 1.2 2013/05/10 05:41:24 patrick Exp $

EAPI="5"

inherit autotools

# no worky
RESTRICT="test"

DESCRIPTION="Rdd is a forensic copy program"
HOMEPAGE="http://www.sf.net/projects/rdd"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
IUSE="debug"
LICENSE="BSD"
SLOT="0"

DEPEND="app-forensics/libewf
	x11-libs/gtk+:2
	gnome-base/libglade:2.0
	app-forensics/libbfio"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/AM_PATH_GTK_2_0//' configure.ac || die
	AT_M4DIR=m4 eautoreconf
	#Workaround to by pass sandbox violation
	sed -i 's:install-binPROGRAMS install-exec-local:install-binPROGRAMS:' src/Makefile.in || die "sed makefile"
}

src_configure() {
	econf \
		$(use_enable debug tracing)
}
src_compile() {
	emake -j1
}

src_install() {
	emake install DESTDIR="${D}"
	#these are in the removed install-exec-local section
	dobin src/rddi.py
	dosym rdd-copy /usr/bin/rdd
	dosym rddi.py /usr/bin/rddi
}
