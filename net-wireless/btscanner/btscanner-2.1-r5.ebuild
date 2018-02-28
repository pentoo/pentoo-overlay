# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools

DESCRIPTION="A utility for bluetooth scanning and discovery"
HOMEPAGE="http://www.pentest.co.uk/cgi-bin/viewcat.cgi?cat=downloads"
SRC_URI="http://www.pentest.co.uk/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=" || ( net-wireless/bluez
	      ( >=net-wireless/bluez-utils-2.15
		>=net-wireless/bluez-libs-2.15 ) )
	>=dev-libs/libxml2-2.6
	>sys-libs/ncurses-5.4"

src_prepare() {
	sed -i -e 's/-Wimplicit-function-dec //g' configure.in
	sed -i 's#-std=c99#-std=gnu99#g' configure.in
	epatch "${FILESDIR}/fix-buffer-overflow.patch"
	epatch "${FILESDIR}/fix-typo-config.patch"
	eapply_user
	mv configure.in configure.ac
	eautoreconf
	sed -i -e '/dtd/ s:/usr/local/:/:' -e '/oui/ s:local/share:share/btscanner:' btscanner.xml
}
src_configure() {
	econf --datadir="/usr/share/btscanner"
	sed -i 's/-lncurses/-lncursesw -ltinfo/' Makefile
}
src_install() {
	DESTDIR="${ED}" emake install
	dodoc AUTHORS ChangeLog README NEWS TODO USAGE
}
