# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-misc/sipbomber/sipbomber-0.7.ebuild,v 1.1.1.1 2006/03/06 22:18:21 grimmlin Exp $

DESCRIPTION="SipBomber is a tool to stress SIP server/proxy implementations."
HOMEPAGE="http://www.metalinkltd.com/downloads.php"
SRC_URI="http://metalinkltd.com/wp-content/uploads/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/qt"

S=${WORKDIR}/${PN}

src_install () {
	newbin sipb_main sipbomber
	dodoc README
}
