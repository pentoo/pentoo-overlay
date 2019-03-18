# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/cookie-import-export
#<install
WEXT_FILEID="1112287"
#<guid>
WEXT_GUID="{91aff32c-1b61-48b3-ac05-5d3682b44527}"

inherit mozilla-webext

DESCRIPTION="Cookie Import Export"
HOMEPAGE="https://addons.mozilla.org/de/firefox/addon/cookie-import-export/"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
