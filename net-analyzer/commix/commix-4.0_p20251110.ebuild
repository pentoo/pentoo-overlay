# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

HASH_COMMIT="b79128c6430e27537d3607c62af8d5295a0d5ddd"

DESCRIPTION="Automated All-in-One OS command injection and exploitation tool"
HOMEPAGE="https://github.com/commixproject/commix"
SRC_URI="https://github.com/commixproject/${PN}/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${HASH_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

#RDEPEND=""
#DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#FIXME: remove --update option
