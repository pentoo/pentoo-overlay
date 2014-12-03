# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FFP_TARGETS="firefox"
inherit mozilla-addon

MOZ_FILEID="135134"

DESCRIPTION="Imports/exports cookies following Netscape standard"
HOMEPAGE="http://addons.mozilla.org/de/firefox/addon/cookies-exportimport/"
SRC_URI="http://addons.mozilla.org/firefox/downloads/file/${MOZ_FILEID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 arm x86"

src_prepare(){
	# the install rdf seems really 'old', with restriction on FF <10.0 ... but it works as well
	# also see: bug https://bugs.gentoo.org/show_bug.cgi?id=515192
	epatch "${FILESDIR}/${PV}-install.rdf.patch" || die 'epatch failed'
}
