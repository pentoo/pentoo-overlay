# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#https://addons.mozilla.org/api/v4/addons/addon/noscript/versions/
#"files":[{"id":
WEXT_FILEID="3365973"
#<guid>
WEXT_GUID="{73a6fe31-595d-460b-a920-fcc0f8843232}"

inherit mozilla-webext

DESCRIPTION="Allow active content in firefox to run only from trusted sites."
HOMEPAGE="http://noscript.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
