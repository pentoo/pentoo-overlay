# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/adblock-plus
#<install
WEXT_FILEID="1130290"
#<guid>
WEXT_GUID="{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}"

inherit mozilla-webext

DESCRIPTION="Firefox extension to block annoying ads automatically, no distractions."
HOMEPAGE="http://adblockplus.org/en/firefox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
