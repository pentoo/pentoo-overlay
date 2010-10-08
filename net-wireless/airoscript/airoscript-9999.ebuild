# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="N00b scripts for aircrack-ng :-)"
HOMEPAGE="http://www.aircrack-ng.org/"
SRC_URI=""
ESVN_REPO_URI="http://trac.aircrack-ng.org/svn/branch/airoscript-ng"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="net-wireless/wireless-tools
	net-wireless/aircrack-ng"

src_compile() {
	elog "Nothing to compile"
}

src_install () {
	sed -e '/PREFIX/ s:/usr/local:/usr:' -e '/MDK3/ s:local/::' -i src/conffiles/airoscript.conf
	emake -j1 prefix="${D}" sysconfdir="${D}etc" datarootdir="${D}usr/share" execprefix="${D}usr" install || die "emake install failed"
	rm -rf "${D}/etc/screenrc" "${D}/usr/share/locale/es_ES"
}
