# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="KARMA + Metasploit 3 == Karmetasploit"
#karmetasploit + kingtuna script
HOMEPAGE="http://trac.metasploit.com/wiki/Karmetasploit"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="net-analyzer/metasploit
	net-wireless/aircrack-ng
	net-misc/dhcp"

src_install() {
    dosbin ${FILESDIR}/karmeta.sh

    dodir /etc
    insinto /etc
    doins ${FILESDIR}/karmeta-dhcpd.conf ${FILESDIR}/karma.rc
}
