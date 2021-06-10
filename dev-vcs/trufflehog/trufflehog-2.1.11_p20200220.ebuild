# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Searches through git repositories for high entropy strings and secrets"
HOMEPAGE="https://github.com/dxa4481/truffleHog"

HASH_COMMIT="4f2acb7bb3145f18ec74c7aab9ced8f38dbcac0c" # 20200220
SRC_URI="https://github.com/dxa4481/truffleHog/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	dev-python/truffleHogRegexes[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/update_setup_py.patch )

S="${WORKDIR}/truffleHog-${HASH_COMMIT}"
