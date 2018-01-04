# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EXT_SHARE_DIR="/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
EXT_ID="wappalyzer@crunchlabz.com"

#blshkv hack, find this number using the following url:
#https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/wappalyzer
#<install
MOZ_FILEID="822619"

DESCRIPTION="A set of proxy management tools for firefox"
HOMEPAGE="http://getfoxyproxy.org"
SRC_URI="https://addons.mozilla.org/downloads/file/${MOZ_FILEID} -> ${P}.xpi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=" || ( >=www-client/firefox-57.0.0 >=www-client/firefox-bin-57.0.0 )"

S=${WORKDIR}

src_unpack(){
	echo
}

src_install(){
	insinto ${EXT_SHARE_DIR}
	newins "${DISTDIR}/${P}".xpi ${EXT_ID}.xpi
}
