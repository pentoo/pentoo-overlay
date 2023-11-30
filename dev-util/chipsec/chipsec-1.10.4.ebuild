# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Platform Security Assessment Framework"
HOMEPAGE="https://github.com/chipsec/chipsec"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE=""

RDEPEND="app-arch/brotli[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest

src_prepare(){
	# https://github.com/chipsec/chipsec/issues/1755
	sed -i "/data_files/d" setup.py || die

	# https://github.com/chipsec/chipsec/pull/1743
	cp -r "${FILESDIR}/Include" ./chipsec_tools/compression/ || die
	eapply_user
}
