# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils subversion
DESCRIPTION="Web application security auditor"
HOMEPAGE="http://wapiti.sourceforge.net/"
ESVN_REPO_URI="https://wapiti.svn.sourceforge.net/svnroot/wapiti/trunk"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
SLOT="0"
RDEPEND="dev-lang/python"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
        dodir /usr/lib/
        # should be as simple as copying everything into the target...
        cp -pPR "${S}/src" "${D}usr/lib/${PN}" || die
	dosym "/usr/lib/${PN}/${PN}.py" "/usr/sbin/${PN}"
        chown -R root:0 "${D}"
	chmod +x "${D}/usr/lib/${PN}/${PN}.py"
}
