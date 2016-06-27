# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mozilla-addon

MOZ_ADDON_ID="344927"
DESCRIPTION="Imports/exports cookies following Netscape standard"
HOMEPAGE="http://addons.mozilla.org/de/firefox/addon/cookies-exportimport/"
SRC_URI="http://addons.mozilla.org/downloads/latest/${MOZ_ADDON_ID} -> ${P}.xpi"

LICENSE="MPL-1.1"
SLOT="0"
#KEYWORDS="~amd64 ~arm ~x86"
KEYWORDS=""
IUSE="+symlink_all_targets target_firefox target_firefox-bin"

RDEPEND="
	!symlink_all_targets? (
		target_firefox? ( www-client/firefox )
		target_firefox-bin? ( www-client/firefox-bin )
	)"

src_prepare(){
	# the install rdf seems really 'old', with restriction on FF <10.0 ... but it works as well
	# also see: bug https://bugs.gentoo.org/show_bug.cgi?id=515192
	epatch "${FILESDIR}/${PV}-install.rdf.patch" || die 'epatch failed'
}

src_install(){
	# symlink all possible target paths if this is set
	if use symlink_all_targets; then
		MZA_TARGETS="firefox firefox-bin"
	else
		use target_firefox && MZA_TARGETS+=" firefox"
		use target_firefox-bin && MZA_TARGETS+=" firefox-bin"
	fi
mozilla-addon_src_install
}
