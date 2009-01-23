# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="athload scripts ripped from compat-wireless"
HOMEPAGE="http://wireless.kernel.org/"
#SRC_URI="${FILESDIR}/athload \
#	${FILESDIR}/modlib.sh \
#	${FILESDIR}/athenable \
#	${FILESDIR}/madwifi-unload \
#	"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

src_install() {
#    einstall || die "einstall failed"
    dodir /usr/sbin
    insinto /usr/sbin
    doins ${FILESDIR}/athload
    doins ${FILESDIR}/athenable
    doins ${FILESDIR}/madwifi-unload

    dodir /usr/lib/compat-wireless
    insinto /usr/lib/compat-wireless
    doins ${FILESDIR}/modlib.sh
}
