# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/adblock-plus
#<install
WEXT_FILEID="865734"
#<guid>
WEXT_GUID="{3e9bb2a7-62ca-4efa-a4e6-f6f6168a652d}"

inherit mozilla-webext

DESCRIPTION="Firefox extensions which shows the IP address(es) of the current page in the status bar."
HOMEPAGE="http://code.google.com/p/firefox-showip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
