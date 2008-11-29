# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${PN}_${PV}.tar.gz"

DESCRIPTION="GNOME/Gtk front-end for the Qemu x86 PC emulator"
HOMEPAGE="http://emeitner.f2o.org/qemu_launcher"
SRC_URI="http://download.gna.org/qemulaunch/1.7.x/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/perl
	>=dev-perl/gtk2-perl-1.121
	>=dev-perl/gtk2-gladexml-1.005
	>=dev-perl/gnome2-perl-1.023
	>=dev-perl/Locale-gettext-1.05
	>=app-emulation/qemu-0.8.1"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	cd "${WORKDIR}/trunk"
	make DESTDIR=${D} install
}
