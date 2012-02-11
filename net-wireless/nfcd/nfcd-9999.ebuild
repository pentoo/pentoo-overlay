# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils subversion
DESCRIPTION="a daemon which access NFC Devices and Targets"
HOMEPAGE="https://code.google.com/p/nfc-tools/wiki/nfcd"
SRC_URI=""
ESVN_REPO_URI="http://nfc-tools.googlecode.com/svn/trunk/nfcd"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libndev
		net-wireless/libfreefare
		dev-libs/libnfc"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
	insinto /etc/dbus-1/system.d/
	doins nfcd.conf || die
}
