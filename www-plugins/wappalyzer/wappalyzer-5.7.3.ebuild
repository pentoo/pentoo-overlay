# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/wappalyzer
#<install
WEXT_FILEID="1677417"
#<guid>
WEXT_GUID="wappalyzer@crunchlabz.com"

inherit mozilla-webext

DESCRIPTION="Cross-platform utility that uncovers the technologies used on websites"
HOMEPAGE="https://github.com/AliasIO/Wappalyzer"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
