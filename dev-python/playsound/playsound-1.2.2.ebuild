# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Single function module with no dependencies for playing sounds"
HOMEPAGE="https://github.com/TaylorSMarks/playsound/"
HASH_COMMIT="907f1fe73375a2156f7e0900c4b42c0a60fa1d00"
SRC_URI="https://github.com/TaylorSMarks/playsound/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
