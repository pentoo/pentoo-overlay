# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

DESCRIPTION="Create and parse NTLM authorisation tokens with all the latest standards"
HOMEPAGE="https://github.com/jborean93/ntlm-auth"
SRC_URI="https://github.com/jborean93/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL"
KEYWORDS="~amd64 ~x86"
IUSE="test"

#DEPEND="test? (
#			dev-python/mock[${PYTHON_USEDEP}]
#			dev-python/requests-mock[${PYTHON_USEDEP}]
#		)"
RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/ordereddict[${PYTHON_USEDEP}]' python2_7)"

python_test() {
	esetup.py test
}
