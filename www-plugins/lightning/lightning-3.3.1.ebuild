# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mozilla-addon

MOZ_FILEID="277302"
DESCRIPTION="Lightning calendar for Thunderbird"
HOMEPAGE="http://www.mozilla.org/en-US/projects/calendar/"
SRC_URI="http://addons.mozilla.org/downloads/file/${MOZ_FILEID} -> ${P}.xpi"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+symlink_all_targets target_thunderbird target_thunderbird-bin"

# symlink all possible target paths if this is set
if use symlink_all_targets; then
	MZA_TARGETS="thunderbird thunderbird-bin"
else
	use target_thunderbird && MZA_TARGETS+=" thunderbird"
	use target_thunderbird-bin && MZA_TARGETS+=" thunderbird-bin"
fi

RDEPEND="
	!symlink_all_targets? (
		target_thunderbird? ( mail-client/thunderbird[-lightning] )
		target_thunderbird-bin? ( mail-client/thunderbird-bin )
	)
	!mail-client/thunderbird[lightning]"
