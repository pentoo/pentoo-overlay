# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

#TODO: the tool is outdated and ruby19 might not be supported properly
USE_RUBY="ruby19"
inherit ruby-ng subversion

DESCRIPTION="A webapplication fingerprinter written in ruby"
HOMEPAGE="http://code.google.com/p/webapplicationfingerprinter/"
SRC_URI=""
ESVN_REPO_URI="http://webapplicationfingerprinter.googlecode.com/svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/sqlite3"

src_install() {
	rm LICENSE || die
	dodoc CREDITS HOWTO README utils/README.generate_wafp_fingerprint\
		utils/SUBMIT_YOUR_FPS
	rm CREDITS HOWTO README utils/README.generate_wafp_fingerprint\
		utils/SUBMIT_YOUR_FPS || die
	exeinto /usr/share/$PN/utils
	doexe utils/*
	rm -rf utils || die
	insinto /usr/share/$PN
	doins -r *
	dobin "${FILESDIR}"/$PN
}
