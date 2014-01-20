# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils multilib

DESCRIPTION="EDB \"Evan's Debugger\" (OllyDbg workalike for Linux)"
HOMEPAGE="http://www.codef00.com/projects.php#debugger"
SRC_URI="http://www.codef00.com/projects/debugger-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND="
	>=dev-qt/qtcore-4.6.0
	>=dev-qt/qtgui-4.6.0
	>=dev-libs/boost-1.35.0"

RDEPEND="${DEPEND}"
S="${WORKDIR}/debugger"

src_configure() {
	qmake -makefile DEFAULT_PLUGIN_PATH="/usr/$(get_libdir)/edb/" || die "qmake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}/usr/" install
	dodoc CHANGELOG README README.plugins
}

pkg_postinst() {
	einfo "Note: EBD's plugins are installed by default into /usr/$(get_libdir)/edb."
	einfo "If you have previously used EDB and have it set to look in a"
	einfo "different directory, then you will need to adjust this. Also"
	einfo "EDB looks for plugins in the current working directory as well"
	einfo "as the directory specified in the options, so that unpriviledged"
	einfo "users can use plugins not installed system wide."
}
