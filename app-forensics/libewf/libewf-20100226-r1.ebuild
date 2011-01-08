# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/libewf/libewf-20100226.ebuild,v 1.2 2010/02/27 10:25:19 patrick Exp $

inherit eutils autotools

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/libewf/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
# upstream bug #2597171, pyewf has implicit declarations
#IUSE="debug python rawio unicode"
IUSE="ewf2 debug rawio unicode"

DEPEND="
	sys-libs/e2fsprogs-libs
	sys-libs/zlib
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable unicode wide-character-type) \
		$(use_enable rawio low-level-functions) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable ewf2 v2-api)
	emake
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS README documents/*.txt
	doman manuals/*.1 manuals/*.3
}
