# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="Searches through git repositories for high entropy strings and secrets"
HOMEPAGE="https://github.com/dxa4481/truffleHog"

HASH_COMMIT="48ffdd3beee3b600939136fccad59f50a2610909" # 20190506
SRC_URI="https://github.com/dxa4481/truffleHog/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	dev-python/truffleHogRegexes[${PYTHON_USEDEP}]
	~dev-python/GitPython-2.1.1[${PYTHON_USEDEP}]"

S="${WORKDIR}/truffleHog-${HASH_COMMIT}"
