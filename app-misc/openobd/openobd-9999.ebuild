# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="neat"
HOMEPAGE=""
EGIT_REPO_URI="git://git.code.sf.net/p/openobd/code"
EGIT_PROJECT=openobd

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_postinst() {
	ewarn "you need to symlink /usr/share/openobd to openOBD"
	ewarn " because I don't care enough to fix it right now"
}
