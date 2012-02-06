# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyscard/pyscard-1.6.12.ebuild,v 1.1 2011/04/03 21:32:47 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils subversion

DESCRIPTION="pyscard is a python module adding smart cards support to python."
HOMEPAGE="http://pyscard.sourceforge.net/ http://pypi.python.org/pypi/pyscard"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
ESVN_REPO_URI="https://pyscard.svn.sourceforge.net/svnroot/pyscard/trunk/pyscard/src/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="smartcard/ACKS smartcard/ChangeLog smartcard/TODO"
PYTHON_MODNAME="smartcard"
