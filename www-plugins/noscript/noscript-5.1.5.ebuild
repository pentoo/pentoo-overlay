# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit mozilla-addon

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/noscript
#<install

MOZ_FILEID="762555"
DESCRIPTION="Allow active content in firefox to run only from trusted sites."
HOMEPAGE="http://noscript.net"
SRC_URI="https://addons.mozilla.org/downloads/file/${MOZ_FILEID} -> ${P}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
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
