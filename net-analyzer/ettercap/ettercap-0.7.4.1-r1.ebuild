# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ettercap/ettercap-0.7.4.1.ebuild,v 1.1 2012/02/04 21:11:14 radhermit Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="A suite for man in the middle attacks and network mapping"
HOMEPAGE="http://ettercap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug gtk ncurses pcre ssl"

# libtool is needed because it provides libltdl (needed for plugins)
RDEPEND=">=net-libs/libnet-1.1.2.1-r1
	net-libs/libpcap
	sys-devel/libtool
	sys-libs/zlib
	gtk? (
		>=dev-libs/glib-2.2.2:2
		>=x11-libs/gtk+-2.2.2:2
	)
	ncurses? ( sys-libs/ncurses )
	pcre? ( dev-libs/libpcre )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex
	virtual/yacc"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.7.3-as-needed.patch
	epatch "${FILESDIR}"/${PN}-0.7.4-autotools.patch
	epatch "${FILESDIR}"/${PN}-0.7.4-flags.patch
	epatch "${FILESDIR}"/${PN}-0.7.4-use-g-idle.patch

	eautoreconf

	#ettercap defaults to using mozilla so let's try to detect firefox and correct
	which firefox-bin && sed -i 's#mozilla#firefox#' "${S}"/share/etter.conf
	which firefox && sed -i 's#mozilla#firefox#' "${S}"/share/etter.conf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable gtk) \
		$(use_with ncurses libncurses "${EPREFIX}"/usr) \
		$(use_with pcre libpcre "${EPREFIX}"/usr) \
		$(use_with ssl openssl "${EPREFIX}"/usr)
}
