# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="KARMA + Metasploit 3 == Karmetasploit"
#karmetasploit + kingtuna script
HOMEPAGE="http://dev.metasploit.com/redmine/projects/framework/wiki/Karmetasploit"

LICENSE="GPL-2"
KEYWORDS="amd64 arm x86"
SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="net-analyzer/metasploit
	>=net-wireless/aircrack-ng-1.2_rc1
	net-misc/dhcp"

src_install() {
	dosbin "${FILESDIR}"/karmeta.sh

	dodir /etc
	insinto /etc
	doins "${FILESDIR}"/karmeta-dhcpd.conf "${FILESDIR}"/karma.rc
}
