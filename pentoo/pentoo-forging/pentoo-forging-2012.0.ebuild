# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Pentoo forging meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

SLOT="0"
LICENSE="GPL-3"
IUSE="minipentoo"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND=""

RDEPEND="${DEPEND}
	net-analyzer/hping
	net-analyzer/macchanger
	!minipentoo? (
		net-analyzer/fragroute
		net-analyzer/gspoof
		net-analyzer/hyenae
		net-analyzer/isic
		net-analyzer/netwag
		net-analyzer/packit
		net-analyzer/rain
		net-misc/ipsorcery
		net-misc/nemesis
	)"
