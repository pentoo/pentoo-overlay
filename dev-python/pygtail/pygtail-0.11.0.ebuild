# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="Reads log file lines that have not been read"
HOMEPAGE="https://github.com/bgreenlee/pygtail"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~arm64 ~mips ~x86"
IUSE=""
DEPEND="${RDEPEND}"
