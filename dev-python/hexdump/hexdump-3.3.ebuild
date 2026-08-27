# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Dump binary data to hex format and restore from there"
HOMEPAGE="https://pypi.org/project/hexdump/"
SRC_URI="$(pypi_sdist_url "${PN}" "${PV}" .zip)"

S=${WORKDIR}

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

BDEPEND="app-arch/unzip"

# remove hexfile.bin, only use for test
src_prepare() {
	sed -i -e "/data_files/d" setup.py
	eapply_user
}
