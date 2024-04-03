# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo bluetooth meta ebuild"
HOMEPAGE="https://www.pentoo.org"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="pentoo-extra pentoo-full"

PDEPEND="
	pentoo-extra? (
		net-wireless/btscanner
	)
	pentoo-full? (
		net-wireless/crackle
		)
	net-wireless/blue_hydra
	net-wireless/blue_sonar
	net-wireless/ice9-bluetooth-sniffer
	net-wireless/kismet
	net-wireless/ubertooth
	net-wireless/blueman"
