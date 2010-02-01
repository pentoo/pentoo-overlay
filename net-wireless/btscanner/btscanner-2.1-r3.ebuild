# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-wireless/btscanner/btscanner-2.1.ebuild,v 1.1.1.1 2006/03/09 22:54:57 grimmlin Exp $

inherit eutils

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

src_compile() {
	sed -i -e 's/-Wimplicit-function-dec //g' configure*
	sed -i -e '/dtd/ s:/usr/local/:/:' -e '/oui/ s:local/share:share/btscanner:' btscanner.xml
	econf --datadir="/usr/share/btscanner" || die "econf failed"
	emake || die "emake failed"
}
src_install() {
	einstall datadir="${D}/usr/share/btscanner" || die "install failed"
	dodoc AUTHORS ChangeLog README NEWS TODO USAGE
}
