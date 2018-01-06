# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/user-agent-switcher-revived
#<install
WEXT_FILEID="759731"
#<guid>
WEXT_GUID="{75afe46a-7a50-4c6b-b866-c43a1075b071}"

inherit mozilla-webext

DESCRIPTION="Adds a menu and a toolbar button to switch the user agent of firefox"
HOMEPAGE="https://mybrowseraddon.com/useragent-switcher.html"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
