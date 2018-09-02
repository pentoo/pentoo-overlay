# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 python3_6 )
inherit distutils-r1

DESCRIPTION="parse ranges easily"
HOMEPAGE="https://bitbucket.org/colinwarren/rangeparser"
SRC_URI="https://files.pythonhosted.org/packages/16/fc/801e1ba6a812192d22d6571eb9b415f20b33b71162e417af7971c6ec216f/RangeParser-0.1.3.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/RangeParser-${PV}"

DEPEND=""
RDEPEND="${DEPEND}"
