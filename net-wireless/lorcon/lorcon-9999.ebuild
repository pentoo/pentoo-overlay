# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs eutils git-2

DESCRIPTION="A generic library for injecting 802.11 frames"
HOMEPAGE="http://802.11ninja.net/lorcon"
SRC_URI=""
#ESVN_REPO_URI="http://802.11ninja.net/svn/lorcon/trunk/"
EGIT_REPO_URI="git clone https://code.google.com/p/lorcon/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="dev-libs/libnl"

#need to add in ruby stuff

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
