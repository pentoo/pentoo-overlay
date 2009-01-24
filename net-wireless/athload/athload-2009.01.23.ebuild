# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="athload scripts ripped from compat-wireless"
HOMEPAGE="http://wireless.kernel.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

src_install() {

    dosbin ${FILESDIR}/athload ${FILESDIR}/athenable ${FILESDIR}/madwifi-unload

    dodir /usr/lib/compat-wireless
    insinto /usr/lib/compat-wireless
    insopts -m0755
    doins ${FILESDIR}/modlib.sh
}
