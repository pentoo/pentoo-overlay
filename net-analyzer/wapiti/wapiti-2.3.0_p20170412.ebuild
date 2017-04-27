# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
PYTHON_REQ_USE='xml'

inherit subversion distutils-r1

DESCRIPTION="Web application security auditor"
HOMEPAGE="http://wapiti.sourceforge.net/"
ESVN_REPO_URI="http://svn.code.sf.net/p/wapiti/code/trunk/"
ESVN_REVISION="368"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ntlm kerberos"

DEPEND=""

#is is better?		dev-python/beautifulsoup:4[$(python_gen_usedep 'python*')]"

RDEPEND="dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/requests-1.2.3[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/tld[${PYTHON_USEDEP}]
	dev-python/yaswfp[${PYTHON_USEDEP}]
	ntlm? ( dev-python/requests-ntlm[${PYTHON_USEDEP}] )
	kerberos? ( dev-python/requests-kerberos[${PYTHON_USEDEP}] )
	"
