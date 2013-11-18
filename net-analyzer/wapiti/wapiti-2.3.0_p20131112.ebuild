# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )
inherit subversion distutils-r1

DESCRIPTION="Web application security auditor"
HOMEPAGE="http://wapiti.sourceforge.net/"
ESVN_REPO_URI="http://svn.code.sf.net/p/wapiti/code/trunk/"
ESVN_REVISION="325"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~arm ~x86"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="dev-python/beautifulsoup[${PYTHON_USEDEP}]
	>=dev-python/requests-1.2.3[${PYTHON_USEDEP}]"
