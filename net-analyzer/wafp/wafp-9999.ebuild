# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion

DESCRIPTION="A webapplication fingerprinter written in ruby"
HOMEPAGE="http://mytty.org/wafp/"
SRC_URI=""
ESVN_REPO_URI="http://webapplicationfingerprinter.googlecode.com/svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-ruby/sqlite3-1.3.6"

src_install() {
	rm LICENSE
	dodoc CREDITS HOWTO README utils/README.generate_wafp_fingerprint\
	utils/SUBMIT_YOUR_FPS
	rm CREDITS HOWTO README utils/README.generate_wafp_fingerprint\
	utils/SUBMIT_YOUR_FPS
	insinto /usr/share/$PN
	doins -r *
	dobin "${FILESDIR}"/$PN
}
