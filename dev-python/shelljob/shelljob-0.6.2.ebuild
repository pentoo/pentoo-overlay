# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Run multiple subprocesses asynchronous/in parallel with streamed output"
HOMEPAGE="https://pypi.org/project/shelljob/"

#https://github.com/mortoray/shelljob/issues/4
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
HASH_COMMIT="545a0a4904ff0d4bb0148e118dc74b0fba875d50"
SRC_URI="https://github.com/mortoray/shelljob/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
