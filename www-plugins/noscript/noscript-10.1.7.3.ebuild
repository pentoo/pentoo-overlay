# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/noscript
#<install
WEXT_FILEID="894351"
#<guid>
WEXT_GUID="{73a6fe31-595d-460b-a920-fcc0f8843232}"

inherit mozilla-webext

DESCRIPTION="Allow active content in firefox to run only from trusted sites."
HOMEPAGE="http://noscript.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
