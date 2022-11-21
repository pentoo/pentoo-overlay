# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Digital Forensics date and time"
HOMEPAGE="https://github.com/log2timeline/dfdatetime"
HASH_COMMIT=${PV}
SRC_URI="https://github.com/log2timeline/dfdatetime/archive/refs/tags/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

RDEPEND="
	>=dev-python/pip-7.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/mock-2.0.0
		>=dev-python/pbr-4.2.0
		>=dev-python/six-1.1.0
	)
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests setup.py
