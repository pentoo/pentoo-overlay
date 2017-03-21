# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mozilla-addon

MOZ_ADDON_ID=722
DESCRIPTION="Allow active content in firefox to run only from trusted sites."
HOMEPAGE="http://noscript.net"
SRC_URI="http://addons.mozilla.org/downloads/latest/${MOZ_ADDON_ID} -> ${P}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+symlink_all_targets target_firefox target_seamonkey target_firefox-bin target_seamonkey-bin"

RDEPEND="
	!symlink_all_targets? (
		target_firefox? ( www-client/firefox )
		target_firefox-bin? ( www-client/firefox-bin )
		target_seamonkey? ( www-client/seamonkey )
		target_seamonkey-bin? ( www-client/seamonkey-bin )
	)"

src_install() {
	# symlink all possible target paths if this is set
	if use symlink_all_targets; then
		MZA_TARGETS="firefox seamonkey firefox-bin seamonkey-bin"
	else
		use target_firefox && MZA_TARGETS+=" firefox"
			use target_firefox-bin && MZA_TARGETS+=" firefox-bin"
		use target_seamonkey && MZA_TARGETS+=" seamonkey"
		use target_seamonkey-bin && MZA_TARGETS+=" seamonkey-bin"
	fi
	mozilla-addon_src_install
}

pkg_postinst() {
	ewarn "This ebuild installs the latest STABLE version !"
	ewarn "It is used by the maintainer to check for new versions ..."
}
