# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV/_alpha/a}"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
#DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1 pypi

DESCRIPTION="Library to (un)pack archives and (de)compress files"
HOMEPAGE="https://rolln.de/knoppo/xtract"
SRC_URI="$(pypi_sdist_url "${PN}" "${MY_PV}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="dev-python/python-magic[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/xtract-${MY_PV}"
