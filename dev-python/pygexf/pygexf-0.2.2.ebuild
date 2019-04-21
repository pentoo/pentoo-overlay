# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A python library to generate gexf file format"
HOMEPAGE="https://github.com/paulgirard/pygexf"
SRC_URI="https://github.com/paulgirard/pygexf/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~x86"
LICENSE="LGPL-3"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/lxml[${PYTHON_USEDEP}]"
