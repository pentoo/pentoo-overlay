# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

#FIXME: migrate to new python eclass
#PYTHON_DEPEND="2"
#inherit subversion python
inherit subversion


DESCRIPTION="A simple piece of PoC code written to demonstrate HTTP POST Denial of Service vulnerabilies"
HOMEPAGE="http://code.google.com/p/post-it-dos/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
ESVN_REPO_URI="http://post-it-dos.googlecode.com/svn/trunk/"
ESVN_PROJECT="postit"

src_prepare() {
	sed -i 's#./ualist.txt#/usr/share/${PN}/ualist.txt#' postit.py
}

src_install() {
	python_convert_shebangs 2 postit.py
	newbin postit.py postit
	dosym /usr/bin/postit /usr/bin/postit.py
	insinto /usr/share/${PN}
	doins ualist.txt
}
