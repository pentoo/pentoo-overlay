# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlat/sqlat-1.1.0.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

inherit eutils
DESCRIPTION="a toolkit that could be used to audit security within Oracle database servers"
HOMEPAGE="http://www.cqure.net/wp/test/"
SRC_URI="http://www.cqure.net/tools/${PN}-binary-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"/"${PN}"
DEPEND="virtual/jre"

src_compile(){
	einfo "Nothing to compile"
	epatch "${FILESDIR}"/"${PN}"-path.patch
}
src_install () {
	insinto /usr/lib/"${PN}"
	doins -r tftproot
	doins ork.jar accounts.default
	dobin *.sh
	dodoc README
}
