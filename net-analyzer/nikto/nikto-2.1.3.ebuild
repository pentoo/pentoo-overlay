# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Web Server vulnerability scanner."
HOMEPAGE="http://www.cirt.net/code/nikto.shtml"
SRC_URI="http://www.cirt.net/nikto/ARCHIVE/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ssl"

RDEPEND="dev-lang/perl
		ssl? (
			dev-libs/openssl
			dev-perl/Net-SSLeay
		)"

src_prepare() {
	sed -i -e 's:config.txt:nikto.conf:g' \
			plugins/* || die

	sed -i -e 's:/etc/nikto.conf:/etc/nikto/nikto.conf:' \
		 nikto.pl || die

	sed -i -e 's:# EXECDIR=/usr/local/nikto:EXECDIR=/usr/share/nikto:' \
		 nikto.conf || die
}

src_compile() {
	einfo "nothing to compile"
	true
}

src_install() {
	insinto /etc/nikto
	doins nikto.conf || die "config install failed"

	dobin nikto.pl || die "install failed"
	dosym /usr/bin/nikto.pl /usr/bin/nikto || die

	dodir /usr/share/nikto
	insinto /usr/share/nikto
	doins -r plugins templates || die

	dodoc docs/*.txt || die
	dohtml docs/nikto_manual.html || die
}
