# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit toolchain-funcs eutils subversion

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/spectools/"
SRC_URI=""
ESVN_REPO_URI="http://svn.kismetwireless.net/code/tools/spectools"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="debug ncurses gtk"

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/libusb
	ncurses? ( sys-libs/ncurses )
	gtk? ( =x11-libs/gtk+-2* )"

src_compile() {
        econf $(use_with gtk gtk-version 2) || die "econf failed"

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
        dobin spectool_net
        use debug && dobin spectool_raw
        use ncurses && dobin spectool_curses
        use gtk && dobin spectool_gtk
#	if use udev; then
		dodir /$(get_libdir)/udev/rules.d/
		insinto /$(get_libdir)/udev/rules.d/
		doins 99-wispy.rules
#	fi
        dodoc README
}
