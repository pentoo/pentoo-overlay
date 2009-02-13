# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils
MY_P="${PN}-${PV/0_/}"
S="${WORKDIR}/${PN}"
DESCRIPTION="Web Application Attack and Audit Framework"
HOMEPAGE="http://w3af.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"
RDEPEND="dev-python/utidylib
	dev-python/soappy"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
        dodir /usr/lib/
        dodir /usr/bin/

        # should be as simple as copying everything into the target...
        cp -pPR ${S} ${D}usr/lib/w3af || die

        # and creating symlinks in the /usr/bin dir
        cd ${D}/usr/bin
       	ln -s ../lib/w3af/w3af ./w3af || die

        chown -R root:0 ${D}

}
