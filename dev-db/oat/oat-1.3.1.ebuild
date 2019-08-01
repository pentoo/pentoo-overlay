# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="a toolkit that could be used to audit security within Oracle database servers"
HOMEPAGE="http://www.cqure.net/wp/test/"
SRC_URI="http://www.vulnerabilityassessment.co.uk/oat-binary-1.3.1.zip"
#SRC_URI="http://www.cqure.net/tools/${PN}-binary-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="virtual/jre"

S="${WORKDIR}"/"${PN}"

src_compile(){
	einfo "Nothing to compile"
	epatch "${FILESDIR}"/"${PN}"-path.patch
}

src_install() {
	insinto /usr/lib/"${PN}"
	doins -r tftproot
	doins ork.jar accounts.default
	dobin *.sh
	dodoc README
}
