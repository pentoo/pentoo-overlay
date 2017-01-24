# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit mozilla-addon

MOZ_FILEID="516537"
DESCRIPTION="Powerful web development tool for firefox"
HOMEPAGE="http://getfirebug.com"
SRC_URI="http://addons.mozilla.org/downloads/file/${MOZ_FILEID} -> ${P}.xpi"

LICENSE="BSD"
SLOT="0"
# blocked because it pulls firefox-bin when I want to keep firefox only
KEYWORDS="amd64 x86"
IUSE="+symlink_all_targets target_firefox target_firefox-bin"

RDEPEND="
	!symlink_all_targets? (
		target_firefox? ( >=www-client/firefox-31.2.0-r1 )
		target_firefox-bin? ( >=www-client/firefox-bin-31.2.0-r1 )
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
