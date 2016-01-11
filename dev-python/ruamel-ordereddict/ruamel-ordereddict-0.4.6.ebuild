# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

MY_P="ruamel.ordereddict-${PV}"

inherit distutils-r1

DESCRIPTION="An ordered dictionary with KIO/KVIO"
HOMEPAGE="https://bitbucket.org/ruamel/ordereddict"
SRC_URI="mirror://pypi/r/ruamel.ordereddict/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND=""
RDEPEND="${DEPEND}"
