# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base subversion eutils

DESCRIPTION="a KDE4 plasmoid which offer NFC content access"
HOMEPAGE="https://github.com/nfc-tools"
SRC_URI=""
ESVN_REPO_URI="http://nfc-tools.googlecode.com/svn/trunk/desknfc"
#https://github.com/raidolepp/libfreefare/tree/master/desknfc

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libndef
	dev-libs/libnfc"
RDEPEND="${DEPEND}"

src_prepare(){
    epatch "${FILESDIR}/${PN}-include.patch"
}
