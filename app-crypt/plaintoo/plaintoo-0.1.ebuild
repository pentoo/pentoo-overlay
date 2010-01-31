# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-crypt/plaintoo/plaintoo-0.1.ebuild,v 1.1.1.1 2006/03/09 22:54:57 grimmlin Exp $

DESCRIPTION="Plaintoo is a pygtk frontend to bkhive and samdump2 (included)"
HOMEPAGE="http://www.plain-text.info/"
SRC_URI="http://www.pentoo.ch/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile () {
	cd "${S}"/apps/bkhive_linux/
	g++ -o bkhive *.cpp || die "bkhive failed"
	cd "${S}"/apps/samdump2_linux/des/
	make || die "des failed"
	cd "${S}"/apps/samdump2_linux/
	make || die "samdump2 failed"
}

src_install () {
	exeinto /opt/plaintoo/
	newexe plaintoo.py plaintoo.py
	insinto /opt/plaintoo/img/
	doins -r img/*
	dosbin "${FILESDIR}"/plaintoo
	dobin apps/bkhive_linux/bkhive
	dobin apps/samdump2_linux/samdump2
}
