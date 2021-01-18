# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# TODO:
# broken with the latest libewf
# see: https://sourceforge.net/p/guymager/feature-requests/11/

EAPI=7

inherit desktop eutils qmake-utils xdg-utils

DESCRIPTION="Guymager is a fast and user friendly forensic imager."
HOMEPAGE="http://guymager.sourceforge.net/"
SRC_URI="mirror://sourceforge/guymager/guymager/LatestSource/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="debug hdparm policykit udisks ewf smart"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	sys-block/parted
	sys-libs/zlib
	sys-process/procps
	hdparm? ( sys-apps/hdparm )
	udisks? ( sys-fs/udisks:* )
	smart? ( sys-apps/smartmontools )
	policykit? ( sys-auth/polkit )"
DEPEND="${RDEPEND}
	ewf? ( app-forensics/libewf )
	>=dev-libs/libguytools2-2.1.0:="

#PATCHES=(
#	"${FILESDIR}"/profile.patch
#)

src_prepare() {
	default
	sed -e "s|^QMAKE_CXXFLAGS_RELEASE += -O3 -ggdb||" \
		-i guymager.pro || die

	lrelease guymager.pro
}

src_configure() {
	eqmake5 DEFINES*="ENABLE_LIBEWF=$(usex ewf '1' '0')"
}

src_install() {
	dobin guymager
	doman manuals/*.1

	newicon -s 128 guymager_128.png guymager.png
	insinto /usr/share/pixmap
	newins guymager_128.xpm guymager.xpm

	if use policykit; then
		insinto /usr/share/polkit-1/actions/
		doins org.freedesktop.guymager.policy

		make_wrapper "${PN}.pkexec" \
			"pkexec \"/usr/bin/guymager\""

		make_desktop_entry "${PN}.pkexec" \
			"Guymager (root)" \
			$PN "Qt;Utility;System"
	fi

	make_desktop_entry $PN \
		"Guymager" \
		$PN "Qt;Utility;System"

	insinto /usr/share/guymager
	doins  guymager_*.ts

	insinto /etc/guymager
	doins guymager.cfg
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
