# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mozilla-addon

MOZ_FILEID="245010"
DESCRIPTION="Lets you switch local proxies in firefox. A fork of multiproxy switch."
HOMEPAGE="http://addons.mozilla.org/en-US/firefox/addon/proxy-selector"
SRC_URI="http://addons.mozilla.org/downloads/file/${MOZ_FILEID} -> ${P}.xpi"

LICENSE="MPL-1.1"
SLOT="0"
# fails to unpack, some problem with the packaging of the xpi?
KEYWORDS="~amd64 ~x86"
IUSE="+symlink_all_targets target_firefox target_firefox-bin"

# symlink all possible target paths if this is set
if use symlink_all_targets; then
	MZA_TARGETS="firefox firefox-bin"
else
	use target_firefox && MZA_TARGETS+=" firefox"
	use target_firefox-bin && MZA_TARGETS+=" firefox-bin"
fi

RDEPEND="
	!symlink_all_targets? (
		target_firefox? ( www-client/firefox )
		target_firefox-bin? ( www-client/firefox-bin )
	)"

#FIXME: it fails to unpack
#src_unpack() {
#    if [ "${A}" != "" ]; then
#	unzip -qo "${DISTDIR}/${A}" -d "${WORKDIR}/"
#    fi
#}
