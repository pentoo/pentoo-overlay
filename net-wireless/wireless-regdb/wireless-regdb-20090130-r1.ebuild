# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wireless-regdb/wireless-regdb-20090130.ebuild,v 1.1 2009/02/02 18:42:21 chainsaw Exp $

MY_P="wireless-regdb-${PV:0:4}.${PV:4:2}.${PV:6:2}"
DESCRIPTION="Binary regulatory database for CRDA"
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="http://wireless.kernel.org/download/wireless-regdb/${MY_P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

inherit eutils

KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""
DEPEND="dev-libs/openssl
	dev-lang/python
	dev-python/m2crypto"
#RDEPEND="${DEPEND}" It doesn't actually have runtime deps afaik
S="${WORKDIR}/${MY_P}"

src_unpack() {
    unpack ${A}
    cd "${S}"
    epatch "${FILESDIR}"/extra-monitor.patch
    emake maintainer-clean || die "make maintainer-clean failed"
}

src_compile() {
	emake key.priv.pem || die "make key.priv.pem failed"
	emake || die "emake failed"
}

src_install() {
	insinto /usr/lib/crda/
	doins regulatory.bin
	doins key.pub.pem
}
