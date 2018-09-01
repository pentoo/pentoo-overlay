# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A simple wrapper for l2ping which shows rssi"
HOMEPAGE="https://github.com/ZeroChaos-/blue_sonar"

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://github.com/ZeroChaos-/blue_sonar.git"
	KEYWORDS=""
	inherit git-r3
else
	KEYWORDS="amd64 arm x86"
	SRC_URI="https://github.com/ZeroChaos-/blue_sonar/archive/0.2.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD-4"
SLOT="0"
IUSE=""

PDEPEND="net-wireless/bluez"

src_install() {
	dosbin blue_sonar
}
