# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="dump mysql client password from memory"
HOMEPAGE="https://github.com/hc0d3r/mysql-magic"
EGIT_REPO_URI="https://github.com/hc0d3r/mysql-magic.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

IUSE=""

src_prepare() {
	#https://github.com/hc0d3r/mysql-magic/pull/2/files
	eapply "${FILESDIR}/pull2-as_needed.patch"
	eapply_user
}

src_install() {
	dobin ${PN}
}
