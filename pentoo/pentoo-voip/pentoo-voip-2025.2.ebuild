# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo voip meta ebuild"
HOMEPAGE="https://www.pentoo.org"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="pentoo-full"

PDEPEND="
	net-voip/sipvicious
	net-misc/sipp

	pentoo-full? (
		net-misc/sipsak
	)"
