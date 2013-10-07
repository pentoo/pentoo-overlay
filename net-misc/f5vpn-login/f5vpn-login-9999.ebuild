# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )
inherit git-2 eutils python-r1

DESCRIPTION="F5 VPN Command-line client"
HOMEPAGE="https://github.com/hackedd/f5vpn-login"
EGIT_REPO_URI="https://github.com/hackedd/f5vpn-login.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/"${PN}"-makefile.patch
}

src_install() {
	emake DESTDIR="${D}" install
}
