# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Kismet WiFi data source shootout"
HOMEPAGE=""
SRC_URI=""
EGIT_REPO_URI="https://github.com/deltj/kis_shootout_python.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
PDEPEND="net-wireless/kismet-rest"
BDEPEND=""

src_install(){
	newbin shootout kismet_shootout
}
