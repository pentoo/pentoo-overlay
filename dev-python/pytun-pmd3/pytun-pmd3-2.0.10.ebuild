# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="python-pytun fork with Darwin support (IPv6-ONLY)"
HOMEPAGE="https://github.com/doronz88/pytun-pmd3"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest

src_prepare(){
	rm -r test
	eapply_user
}
