# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/foxyproxy-standard
#<install

#https://services.addons.mozilla.org/api/v3/addons/search/?guid=foxyproxy@eric.h.jung
#"files":[{"id"
WEXT_FILEID="3466053"
#<guid>
WEXT_GUID="foxyproxy@eric.h.jung"

inherit mozilla-webext

DESCRIPTION="An advanced proxy management tool"
HOMEPAGE="http://getfoxyproxy.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
