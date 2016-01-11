# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python SDK to access the vulnerability database"
HOMEPAGE="https://github.com/vulndb/python-sdk/"
SRC_URI="https://pypi.python.org/packages/source/v/vulndb/vulndb-0.0.19.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#FIXME: missing yanc==0.2.4
DEPEND=">=dev-python/nose-1.3.4
	>=dev-python/pylint-1.0.0
	>=dev-python/setuptools-git-1.1
	>=dev-python/termcolor-1.1.0
	"
RDEPEND="${DEPEND}"
