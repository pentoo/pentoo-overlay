# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="athload scripts ripped from compat-wireless"
HOMEPAGE="http://wireless.kernel.org/"
SRC_URI="http://someplace.whatever.fake.com/path/to/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

src_compile() {
    fperms 755 * || echo "failed to set permissions"
}

src_install() {

    dodir /usr/sbin
    insinto /usr/sbin
    doins ${WORKDIR}/athload
    doins ${WORKDIR}/athenable
    doins ${WORKDIR}/madwifi-unload

    dodir /usr/lib/compat-wireless
    insinto /usr/lib/compat-wireless
    doins ${WORKDIR}/modlib.sh
}
