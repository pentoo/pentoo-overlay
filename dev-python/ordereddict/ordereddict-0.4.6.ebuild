# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="a version of dict that keeps keys in insertion resp. sorted order"
HOMEPAGE="https://bitbucket.org/ruamel/ordereddict"
#SRC_URI="mirror://pypi/${PN:0:1}/ruamel.${PN}/ruamel.${P}.tar.gz"
SRC_URI="https://pypi.python.org/packages/source/r/ruamel.ordereddict/ruamel.ordereddict-0.4.6.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/ruamel.ordereddict-0.4.6

DEPEND=""
RDEPEND="${DEPEND}"
