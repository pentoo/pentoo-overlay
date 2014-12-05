# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mozilla-addon

MOZ_ADDON_ID=4631
DESCRIPTION="Allows Lightning to read and write events and tasks to a Google Calendar"
HOMEPAGE="http://addons.mozilla.org/en-us/thunderbird/addon/provider-for-google-calendar/"
SRC_URI="http://addons.mozilla.org/downloads/file/${MOZ_ADDON_ID} -> ${P}.xpi"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

pkg_postinst() {
	ewarn "This ebuild installs the latest STABLE version !"
	ewarn "It is used by the maintainer to check for new versions ..."
}
