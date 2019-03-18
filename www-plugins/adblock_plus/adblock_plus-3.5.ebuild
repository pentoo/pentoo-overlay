# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#https://addons.mozilla.org/api/v4/addons/addon/adblock-plus/versions/
#files":[{"id"
WEXT_FILEID="1709104"
#"guid":"
WEXT_GUID="{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}"

inherit mozilla-webext

DESCRIPTION="Firefox extension to block annoying ads automatically, no distractions."
HOMEPAGE="http://adblockplus.org/en/firefox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
