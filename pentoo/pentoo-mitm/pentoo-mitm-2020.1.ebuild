# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo mitm meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

PDEPEND="
	net-analyzer/ettercap
	net-misc/bridge-utils
	net-analyzer/bettercap
"
