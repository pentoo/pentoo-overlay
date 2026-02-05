# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="KARMA + Metasploit 3 == Karmetasploit"
#karmetasploit + kingtuna script
HOMEPAGE="http://dev.metasploit.com/redmine/projects/framework/wiki/Karmetasploit"

#SRI_URI="https://manage.offsec.com/app/uploads/2015/04/karma.rc_.txt"
S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="net-analyzer/metasploit
	>=net-wireless/aircrack-ng-1.2_rc1
	net-misc/dhcp"

src_install() {
	dosbin "${FILESDIR}"/karmeta.sh

	insinto /etc
	doins "${FILESDIR}"/karmeta-dhcpd.conf "${FILESDIR}"/karma.rc
}
