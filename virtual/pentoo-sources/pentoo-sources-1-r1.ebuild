# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Meta package for Pentoo kernel sources"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="lts"

# The logic flow:
#  If we install virtual/pentoo-sources we want sys-kernel/pentoo-sources
#  Maybe later that will include sys-kernel/pentoo-kernel when it exists
#  If we have the lts use flag set, we have to have a sources installed with the lts flag set AND
#  no sources installed without the lts flag set otherwise we might accidently build a non-lts kernel.

# The - indicates the existing use flag must be disabled
# The (-) indicates that the missing flag is assumed to be disabled
# if this is simplified to sys-kernel/pentoo-sources[lts?(-)] it would allow users who previously had lts unset to keep non-lts kernel sources installed which breaks the intent
RDEPEND="
	sys-kernel/pentoo-sources
	lts? (
		sys-kernel/pentoo-sources[lts]
		!sys-kernel/pentoo-sources[-lts(-)]
	)
"
