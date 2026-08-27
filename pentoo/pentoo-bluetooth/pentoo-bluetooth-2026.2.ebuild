# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo bluetooth meta ebuild"
HOMEPAGE="https://www.pentoo.org"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="pentoo-extra pentoo-full"

PDEPEND="
	pentoo-extra? (
		amd64? ( net-wireless/btscanner )
	)
	pentoo-full? (
		amd64? (
			net-wireless/Sniffle
			net-wireless/crackle
		)
	)
	amd64? (
		net-wireless/blue_hydra
		net-wireless/ice9-bluetooth-sniffer
	)
	net-wireless/blue_sonar
	net-wireless/kismet
	net-wireless/ubertooth
	net-wireless/blueman"
