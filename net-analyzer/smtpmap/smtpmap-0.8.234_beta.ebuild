# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

MY_P=${P/_beta/-BETA}

DESCRIPTION="a very complete and well done fingerprinter for SMTP, FTP and POP3 fingerprinter"
HOMEPAGE="http://www.projectiwear.org/~plasmahh/software.html"
SRC_URI="http://www.projectiwear.org/~plasmahh/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_configure(){
	epatch "${FILESDIR}"/gcc-3.4.patch
	epatch "${FILESDIR}"/smtpmap-64bit.patch
	sed -i "s|-O -Wall|$CFLAGS|g" makefile.conf || die "sed failed"
}

src_compile() {
	./configure
	# It has is own configuration script... maybe some sed here after needs to be done
	emake || die "make failed"
}

src_install() {
	insinto /usr/share/smtpmap
	doins share/*
	dobin src/smtpmap
	dodoc ChangeLog README TODO
}
