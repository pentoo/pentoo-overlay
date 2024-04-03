# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
DESCRIPTION="KARMA + Metasploit 3 == Karmetasploit"
#karmetasploit + kingtuna script
HOMEPAGE="http://dev.metasploit.com/redmine/projects/framework/wiki/Karmetasploit"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="net-analyzer/metasploit
	>=net-wireless/aircrack-ng-1.2_rc1
	net-misc/dhcp"

src_install() {
	dosbin "${FILESDIR}"/karmeta.sh

	insinto /etc
	doins "${FILESDIR}"/karmeta-dhcpd.conf "${FILESDIR}"/karma.rc
}
