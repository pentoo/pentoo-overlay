# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/user-agent-switcher-revived
#<install
WEXT_FILEID="822619"
#<guid>
WEXT_GUID="wappalyzer@crunchlabz.com"

inherit mozilla-webext

DESCRIPTION="Cross-platform utility that uncovers the technologies used on websites"
HOMEPAGE="https://github.com/AliasIO/Wappalyzer"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
