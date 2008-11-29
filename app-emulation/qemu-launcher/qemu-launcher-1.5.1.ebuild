# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-emulation/qemu-launcher/qemu-launcher-1.5.1.ebuild,v 1.1.1.1 2006/03/06 22:19:49 grimmlin Exp $

MY_P="${PN}_${PV}-1.tar.gz"

DESCRIPTION="GNOME/Gtk front-end for the Qemu x86 PC emulator"
HOMEPAGE="http://emeitner.f2o.org/qemu_launcher"
SRC_URI="http://emeitner.f2o.org/debian/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE=""

DEPEND="dev-lang/perl
	>=dev-perl/gtk2-perl-1.101
	>=dev-perl/gtk2-gladexml-1.005
	>=dev-perl/gnome2-perl-1.023
	>=dev-perl/Locale-gettext-1.05"

pkg_nofetch() {
	einfo "Due to restrictions on server please"
	einfo "download ${SRC_URI}"
	einfo "manually with a web browser"
	einfo "and put it in ${DISTDIR}"
}

src_install() {
	cd "${WORKDIR}/trunk"
	make DESTDIR=${D} install
}
