# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}-fx"
DESCRIPTION="Firefox extension to block annoying ads automatically, no distractions."
HOMEPAGE="http://adblockplus.org/en/firefox"
SRC_URI="mirror://mozilla/addons/344927/${FFP_XPI_FILE}.xpi"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

src_prepare(){
	#quick hack for the bug https://bugs.gentoo.org/show_bug.cgi?id=515192
	cd ${WORKDIR}/${FFP_XPI_FILE}
	sed -e "s|<id>CookiesIE@yahoo.com</id>| \
		<id>CookiesIE@yahoo.com</id><em:id>CookiesIE@yahoo.com</em:id> |g" -i install.rdf || die "sed failed"
}
