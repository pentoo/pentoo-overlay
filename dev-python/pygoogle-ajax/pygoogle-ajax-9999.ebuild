# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit subversion distutils

DESCRIPTION="a very basic Google search module for Python using the AJAX API"
HOMEPAGE="http://code.google.com/p/pygoogle/"
ESVN_REPO_URI="http://pygoogle.googlecode.com/svn/trunk/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!dev-python/pygoogle"
