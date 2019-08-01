# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo mitm meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="pentoo-full"

PDEPEND="
	net-analyzer/ettercap
	net-misc/bridge-utils
	net-analyzer/bettercap

	pentoo-full? (
		net-analyzer/sslstrip
	)"
