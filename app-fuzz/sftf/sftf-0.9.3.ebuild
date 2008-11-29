# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuz/sftf/sftf-0.9.3.ebuild,v 1.1.1.1 2006/03/21 13:40:40 grimmlin Exp $

DESCRIPTION="SFTF is a SIP user agent fuzzer"
HOMEPAGE="http://www.sipfoundry.org/sftf/index.html"
MY_P="SFTF"
SRC_URI="http://www.sipfoundry.org/pub/${MY_P}/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}-${PV}

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	insinto /opt/${PN}/
	insopts -m0755
	doins -r *.py BodyParser/ UserAgentBasicTestSuite/ HFH/
	dodoc TODO Docs/* UserAgentBasicTestSuite/case_template
	dosbin "${FILESDIR}"/sftf
}
