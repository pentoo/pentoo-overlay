# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/adblock-plus
#<install
WEXT_FILEID="773845"
#<guid>
WEXT_GUID="{c45c406e-ab73-11d8-be73-000a95be3b12}"

inherit mozilla-webext

DESCRIPTION="Adds various web developer tools to firefox."
HOMEPAGE="http://chrispederick.com/work/web-developer"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
