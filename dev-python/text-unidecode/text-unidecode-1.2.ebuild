# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="The most basic Text::Unidecode port"
HOMEPAGE="https://pypi.org/project/text-unidecode/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64 ~arm64 ~mips ~x86"
IUSE=""
RDEPEND="${PYTHON_DEPS}"
