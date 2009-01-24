# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/crda/crda-0.9.5.ebuild,v 1.4 2008/12/02 17:03:21 ranger Exp $

inherit toolchain-funcs

DESCRIPTION="Central Regulatory Domain Agent for wireless networks."
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="http://wireless.kernel.org/download/crda/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND="dev-libs/libgcrypt
	dev-libs/libnl
	dev-python/m2crypto
	net-wireless/wireless-regdb"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
