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

DEPEND=">=app-forensics/libewf-20110801
	app-forensics/libbfio"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable debug tracing) --enable-static
	#Workaround to by pass sandbox violation
	sed -i 's:install-binPROGRAMS install-exec-local:install-binPROGRAMS:' src/Makefile || die "sed makefile"
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
