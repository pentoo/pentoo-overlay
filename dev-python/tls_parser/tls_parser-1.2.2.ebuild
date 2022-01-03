# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Small library to parse TLS records."
HOMEPAGE="https://github.com/nabla-c0d3/tls_parser"
SRC_URI="https://github.com/nabla-c0d3/tls_parser/archive/${PV}.tar.gz -> ${P}.tar.gz"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
