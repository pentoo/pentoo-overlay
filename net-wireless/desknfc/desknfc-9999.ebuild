# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit kde4-base subversion

DESCRIPTION="a KDE4 plasmoid which offer NFC content access"
HOMEPAGE="https://code.google.com/p/nfc-tools/wiki/desknfc"
SRC_URI=""
ESVN_REPO_URI="http://nfc-tools.googlecode.com/svn/trunk/desknfc"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libndef"
RDEPEND="${DEPEND}"
