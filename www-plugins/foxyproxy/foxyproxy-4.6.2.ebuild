# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id $

EAPI=5

inherit mozilla-addon

#blshkv hack, find this number using the following url:
#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/foxyproxy-standard
#<install
MOZ_FILEID="575912"
DESCRIPTION="A set of proxy management tools for firefox"
HOMEPAGE="http://getfoxyproxy.org"
SRC_URI="https://addons.mozilla.org/downloads/file/${MOZ_FILEID} -> ${P}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
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
