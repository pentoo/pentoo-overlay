# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion

DESCRIPTION="All exploits from explo.it"
HOMEPAGE="http://explo.it"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""

DEPEND=""
RDEPEND=""

ESVN_REPO_URI="svn://devel.offensive-security.com/exploitdb"

src_install() {
	rm archive.tar.bz2
	insinto /usr/share/exploits/$PN
	doins -r * || die "install failed"
}
