# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop toolchain-funcs xdg-utils

DESCRIPTION="An utility to detect and resist arp spoofing"
HOMEPAGE="https://sourceforge.net/projects/arpantispoofer/"
SRC_URI="mirror://sourceforge/$PN/$PN-linux-$PV.tar.bz2"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	net-libs/libpcap
	x11-libs/gtk+:2
	x11-libs/libnotify"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/fix_errors_while_building.patch"
	"${FILESDIR}/update_Makefile.patch"
)

S="${WORKDIR}"

src_compile() {
	emake CPPC=$(tc-getCXX)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dosym ../sbin/arpas /usr/bin/arpas

	make_desktop_entry arpas \
		"ARP AntiSpoofer" \
		"arpas" "Network"

	newdoc readme.txt README
	dodoc ChangeLog
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
