# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Traceback fiddling library"
HOMEPAGE="https://github.com/ionelmc/python-tblib"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/ionelmc/python-tblib"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/ionelmc/python-tblib/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/python-${P}"

DEPEND=""
RDEPEND="${DEPEND}"
