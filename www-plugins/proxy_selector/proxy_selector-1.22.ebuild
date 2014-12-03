# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

FFP_TARGETS="firefox"
inherit mozilla-addon

MOZ_FILEID="245010"
DESCRIPTION="Lets you switch local proxies in firefox. A fork of multiproxy switch."
HOMEPAGE="http://addons.mozilla.org/en-US/firefox/addon/proxy-selector"
SRC_URI="http://addons.mozilla.org/firefox/downloads/file/${MOZ_FILEID} -> ${FFP_XPI_FILE}.xpi"

LICENSE="MPL-1.1"
SLOT="0"
# fails to unpack, some problem with the packaging of the xpi?
KEYWORDS="~amd64 ~x86"

#FIXME: it fails to unpack
#src_unpack() {
#    if [ "${A}" != "" ]; then
#	unzip -qo "${DISTDIR}/${A}" -d "${WORKDIR}/"
#    fi
#}
