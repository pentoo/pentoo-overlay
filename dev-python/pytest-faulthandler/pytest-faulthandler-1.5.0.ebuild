# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="py.test plugin that activates the fault handler module during testing"
HOMEPAGE="https://github.com/pytest-dev/pytest-faulthandler"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/faulthandler[${PYTHON_USEDEP}]' python2_7} )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
