# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Google Play Downloader via Command line"
HOMEPAGE="https://github.com/matlink/gplaycli"
SRC_URI="https://github.com/matlink/gplaycli/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/matlink-gpapi-0.4.4.5[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/pyaxmlparser[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/3.29-confpath.patch" )
