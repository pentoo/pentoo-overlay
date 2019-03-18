# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Xorg-x11 configuration builder - used only on LiveCD"
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI="http://dev.pentoo.ch/~grimmlin/distfiles/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~mips ppc x86"
IUSE=""

RDEPEND="!mips? ( sys-apps/hwsetup )"

PATCHES=(
	"${FILESDIR}"/${P}.patch
	"${FILESDIR}"/virtualbox-workaround.patch

	#The below patch has REMOVED text from the input xorg.conf file
	#The removed text INCORRECTLY uses the "mouse" and "kbd" drivers
	#These drivers have been deprecated in X and autodetction works flawlessly anyway
	"${FILESDIR}"/let-x-autodetect-kbd-mouse.patch
	"${FILESDIR}"/allow-auto-add-devices.patch
)

src_install() {
	newinitd "${FILESDIR}"/mkxf86config.initd ${PN}

	insinto /etc/X11
	if use mips; then
		doins xorg.conf.impact xorg.conf.newport xorg.conf.o2-fbdev
	else
		doins xorg.conf.in
	fi

	dosbin mkxf86config.sh
}

pkg_postinst() {
	ewarn "This package is designed for use on the LiveCD only and will do "
	ewarn "unspeakably horrible and unexpected things on a normal system.\n"
	ewarn "YOU HAVE BEEN WARNED!!!"
}
