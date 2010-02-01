# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs eutils subversion

DESCRIPTION="A generic library for injecting 802.11 frames"
HOMEPAGE="http://802.11ninja.net/lorcon"
SRC_URI=""
ESVN_REPO_URI="https://802.11ninja.net/svn/lorcon/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="<dev-libs/libnl-2"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
