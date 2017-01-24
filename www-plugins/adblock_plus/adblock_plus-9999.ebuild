# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id $

EAPI=5

inherit mozilla-addon

MOZ_ADDON_ID=1865
DESCRIPTION="Firefox extension to block annoying ads automatically, no distractions."
HOMEPAGE="http://adblockplus.org/en/firefox"
SRC_URI="http://addons.mozilla.org/downloads/latest/${MOZ_ADDON_ID} -> ${P}.xpi"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+symlink_all_targets target_firefox target_thunderbird target_seamonkey target_firefox-bin target_thunderbird-bin target_seamonkey-bin"

RDEPEND="
	!symlink_all_targets? (
		target_firefox? ( www-client/firefox )
		target_firefox-bin? ( www-client/firefox-bin )
		target_seamonkey? ( www-client/seamonkey )
		target_seamonkey-bin? ( www-client/seamonkey-bin )
		target_thunderbird? ( mail-client/thunderbird )
		target_thunderbird-bin? ( mail-client/thunderbird-bin )
	)"

src_install() {
	# symlink all possible target paths if this is set
	if use symlink_all_targets; then
		MZA_TARGETS="firefox thunderbird seamonkey firefox-bin thunderbird-bin seamonkey-bin"
	else
		use target_firefox && MZA_TARGETS+=" firefox"
		use target_firefox-bin && MZA_TARGETS+=" firefox-bin"
		use target_thunderbird && MZA_TARGETS+=" thunderbird"
		use target_thunderbird-bin && MZA_TARGETS+=" thunderbird-bin"
		use target_seamonkey && MZA_TARGETS+=" seamonkey"
		use target_seamonkey-bin && MZA_TARGETS+=" seamonkey-bin"
	fi
	mozilla-addon_src_install
}

pkg_postinst() {
	ewarn "This ebuild installs the latest STABLE version !"
	ewarn "It is used by the maintainer to check for new versions ..."
}
