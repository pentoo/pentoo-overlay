# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Read DBF Files with Python"
HOMEPAGE="https://dbfread.readthedocs.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~mips ~x86"
# IUSE="test"
# REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}"

## TODO
# distutils_enable_tests pytest

# src_prepare() {
# 	default
# 	use test && eapply "${FILESDIR}/${P}_fix_tests.patch"
# }
