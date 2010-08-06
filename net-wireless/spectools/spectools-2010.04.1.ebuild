# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit toolchain-funcs eutils autotools

MY_P=${P/\./-}
MY_P=${MY_P/./-R}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/spectools/"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="debug ncurses gtk"

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/libusb
	ncurses? ( sys-libs/ncurses )
	gtk? ( =x11-libs/gtk+-2*
		x11-libs/cairo )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-configure.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable gtk) \
		  $(use_enable ncurses) || die
}

src_compile() {
	emake depend || die "emake DEPEND filed"

	if use debug; then
		emake spectool_raw || die "emake spectool_raw failed"
	fi

	if use ncurses; then
		emake spectool_curses || die "emake spectool_curses failed"
	fi

	if use gtk; then
		emake spectool_gtk || die "emake spectool_gtk failed"
	fi

	emake spectool_net || die "emake spectool_net failed"

}

src_install() {
	dobin spectool_net || die
	if use debug; then
		dobin spectool_raw || die
	fi
	if use ncurses; then
		dobin spectool_curses || die
	fi
	if use gtk; then
		dobin spectool_gtk || die
	fi
	dodir /$(get_libdir)/udev/rules.d/
	insinto /$(get_libdir)/udev/rules.d/
	doins 99-wispy.rules || die
	dodoc README || die
}
