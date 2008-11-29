# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
MY_P=${P/_beta/-BETA}
DESCRIPTION="Smtpmap is a very complete and well done fingerprinter for SMTP, FTP and POP3 fingerprinter"
HOMEPAGE="http://www.projectiwear.org/~plasmahh/software.html"
SRC_URI="http://www.projectiwear.org/~plasmahh/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=""
S=${WORKDIR}/${MY_P}

src_compile(){
	epatch ${FILESDIR}/gcc-3.4.patch
	./configure
#	It has is own configuration script... maybe some sed here after needs to be done
	emake || die "make failed"
}

src_install() {
	insinto /usr/share/smtpmap
	doins share/*
	dobin src/smtpmap
	dodoc ChangeLog README TODO
}
