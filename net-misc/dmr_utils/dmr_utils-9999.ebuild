# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="Python utilities for working with DMR"
HOMEPAGE="https://github.com/n0mjs710/dmr_utils"
SRC_URI=""
EGIT_REPO_URI="https://github.com/n0mjs710/dmr_utils.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/bitarray"
RDEPEND="${DEPEND}"
