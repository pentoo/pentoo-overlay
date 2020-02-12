# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="A module to produce pretty and readable YAML-serialized data"
HOMEPAGE="https://github.com/mk-fg/pretty-yaml"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
