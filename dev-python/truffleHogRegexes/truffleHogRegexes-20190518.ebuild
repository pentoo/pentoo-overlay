# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

DESCRIPTION="These are the regexes that power trufflehog"
HOMEPAGE="https://github.com/dxa4481/truffleHogRegexes"

HASH_COMMIT="a73e8d3304f37bca4f85e44e533c9797eb6d0b95" # 20190518
SRC_URI="https://github.com/dxa4481/truffleHogRegexes/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/truffleHogRegexes-${HASH_COMMIT}"
