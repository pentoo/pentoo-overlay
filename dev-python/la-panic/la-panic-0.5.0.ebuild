# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="iPhone kernel panic parser"
HOMEPAGE="https://gitlab.com/yanivhasbanidev/la_panic"
SRC_URI="https://gitlab.com/yanivhasbanidev/la_panic/-/archive/${PV}/la_panic-${PV}.tar.bz2"
S="${WORKDIR}/${PN/-/_}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
