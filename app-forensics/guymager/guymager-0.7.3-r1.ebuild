# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI="5"

inherit qt4-r2

DESCRIPTION="Guymager is a fast and user friendly forensic imager."
HOMEPAGE="http://guymager.sourceforge.net/"
#SRC_URI="mirror://sourceforge/guymager/${PV}.tar.gz"
SRC_URI="mirror://debian/pool/main/g/guymager/${P//-/_}.orig.tar.gz ->  ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~arm ~amd64"
IUSE="debug hdparm udisk smart parted"

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtdbus
	sys-libs/zlib
	sys-process/procps
	hdparm? ( sys-apps/hdparm )
	udisk? ( sys-fs/udisks )
	smart? ( sys-apps/smartmontools )
	parted? ( sys-block/parted )"
DEPEND="${RDEPEND}
	x11-libs/gksu
	app-forensics/libewf
	dev-libs/libguytools2:="

PATCHES=(
	"${FILESDIR}/systemlibs.patch"
	"${FILESDIR}/support_new_libewf.patch"
)

src_configure() {
	eqmake4
}

src_compile() {
	make
	lrelease guymager.pro

	cd manuals
	./rebuild.sh
}

src_install() {
	dobin guymager
	doman manuals/guymager.1

	insinto /usr/share/guymager
	doins  guymager_*.ts

	insinto /etc/guymager
	doins guymager.cfg

	doicon guymager_128.png
	domenu guymager.desktop
}
