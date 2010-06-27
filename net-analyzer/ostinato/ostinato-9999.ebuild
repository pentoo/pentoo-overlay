# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit qt4-r2 mercurial versionator

DESCRIPTION="A packet generator and alayzer"
HOMEPAGE="http://code.google.com/p/ostinato/"
SRC_URI=""
EHG_REPO_URI="https://ostinato.googlecode.com/hg"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/protobuf
	net-libs/libpcap
	x11-libs/qt-core
	x11-libs/qt-gui
	x11-libs/qt-script"
RDEPEND="${DEPEND}"

S="${WORKDIR}/hg/"
