# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 pypi

DESCRIPTION="Dump binary data to hex format and restore from there"
HOMEPAGE="https://pypi.org/project/hexdump/"
SRC_URI="$(pypi_sdist_url "${PN}" "${PV}" .zip)"

S=${WORKDIR}

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"
