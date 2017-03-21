# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mozilla-addon

MOZ_ADDON_ID=2464
DESCRIPTION="A set of proxy management tools for firefox"
HOMEPAGE="http://getfoxyproxy.org"
SRC_URI="http://addons.mozilla.org/downloads/latest/${MOZ_ADDON_ID} -> ${P}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+symlink_all_targets target_firefox target_firefox-bin"

RDEPEND="
	!symlink_all_targets? (
		target_firefox? ( www-client/firefox )
		target_firefox-bin? ( www-client/firefox-bin )
	)"

src_install() {
	# symlink all possible target paths if this is set
	if use symlink_all_targets; then
		MZA_TARGETS="firefox firefox-bin"
	else
		use target_firefox && MZA_TARGETS+=" firefox"
		use target_firefox-bin && MZA_TARGETS+=" firefox-bin"
	fi
	mozilla-addon_src_install
}

pkg_postinst() {
	ewarn "This ebuild installs the latest STABLE version !"
	ewarn "It is used by the maintainer to check for new versions ..."
}
