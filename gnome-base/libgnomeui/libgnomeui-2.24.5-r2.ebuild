# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit eutils gnome2 virtualx

DESCRIPTION="User Interface part of libbonobo"
HOMEPAGE="https://developer.gnome.org/libbonoboui/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="examples test gnome-keyring"

# GTK+ dep due to bug #126565
RDEPEND="
	>=gnome-base/libgnomecanvas-1.116
	>=gnome-base/libbonobo-2.22
	>=gnome-base/libgnome-2.13.7
	>=dev-libs/libxml2-2.4.20:2
	>=gnome-base/gconf-2:2
	>=x11-libs/gtk+-2.8.12:2
	>=dev-libs/glib-2.6.0:2
	>=gnome-base/libglade-1.99.11:2.0
	>=dev-libs/popt-1.5
	gnome-keyring? ( >=gnome-base/gnome-keyring-0.4
		gnome-base/libgnome-keyring )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	x11-apps/xrdb
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.40
"

src_prepare() {
	if ! use test; then
		# don't waste time building tests
		sed 's/tests//' -i Makefile.am Makefile.in || die "sed 1 failed"
	fi

	if ! use examples; then
		sed 's/samples//' -i Makefile.am Makefile.in || die "sed 2 failed"
	fi

	#keyring can be optional, it is disabled in win32 for example
	#https://bugzilla.gnome.org/show_bug.cgi?id=768754
	if ! use gnome-keyring; then
		sed -i 's|GNOME_KEYRING=\"gnome-keyring-1\"|GNOME_KEYRING=\"\"|g' configure || die "sed failed"
		sed -i 's|gnome_keyring_requirement=\"gnome-keyring-1 >= 0.4\"|gnome_keyring_requirement=\"\"|g'  configure || die "sed failed"
		sed -i 's|@OS_WIN32_FALSE@am__objects_1 = gnome-authentication-manager.lo|@OS_WIN32_FALSE@am__objects_1 = |g'  libgnomeui/Makefile.in || die "sed failed"
	fi

	gnome2_src_prepare
}

src_configure() {
	addpredict "/root/.gnome2_private"
	gnome2_src_configure --disable-static
}

src_test() {
	addpredict "/root/.gnome2_private"
	Xemake check
}
