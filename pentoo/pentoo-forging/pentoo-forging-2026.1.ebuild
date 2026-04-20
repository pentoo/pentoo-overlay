# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo forging meta ebuild"
HOMEPAGE="https://www.pentoo.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="pentoo-extra pentoo-full"

PDEPEND="
	net-analyzer/hping
	net-analyzer/macchanger
	pentoo-full? (
		net-analyzer/fragroute
		net-misc/ipsorcery
	)
	pentoo-extra? (
		net-analyzer/gspoof
		net-analyzer/isic
		net-analyzer/rain
	)
"
