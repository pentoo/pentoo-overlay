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

#src_prepare() {
#	eapply "${FILESDIR}/pull3-cosmetic.patch"
#	eapply "${FILESDIR}/ignotum_pull2-ldflags.patch"
#	eapply_user
#}

src_install() {
	dobin ${PN}
}
