# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Meta package for Pentoo kernel sources"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="lts"

# The (-) indicates that the missing flag is assumed to be disabled
RDEPEND="
	lts? (
		sys-kernel/pentoo-sources[lts]
		!sys-kernel/pentoo-sources[-lts]
	)
	!lts? (
		sys-kernel/pentoo-sources[-lts(-)]
		!sys-kernel/pentoo-sources[lts]
	)
"
#DEPEND="
#	sys-kernel/pentoo-sources[lts?]
#"
