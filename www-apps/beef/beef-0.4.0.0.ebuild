# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit webapp

DESCRIPTION="browser exploitation framework"
HOMEPAGE="http://www.bindshell.net/tools/beef"
SRC_URI="http://www.bindshell.net/tools/beef/$PN-v$PV.tar.gz"

LICENSE=""
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/php[filter]"

src_install() {
	webapp_src_preinst
	cp -R beef/* "${D}"/${MY_HTDOCSDIR}
	webapp_serverowned ${MY_HTDOCSDIR}/include
	webapp_serverowned -R ${MY_HTDOCSDIR}/cache
	webapp_src_install
}
