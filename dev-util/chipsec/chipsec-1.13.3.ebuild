# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit linux-mod-r1 distutils-r1 pypi

DESCRIPTION="Platform Security Assessment Framework"
HOMEPAGE="https://github.com/chipsec/chipsec"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="+chipsec-driver"

RDEPEND="app-arch/brotli[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# compile against selected (not running) target
pkg_setup() {
	if use chipsec-driver; then
		linux-mod-r1_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare(){
	# https://github.com/chipsec/chipsec/issues/1755
	sed -i "/data_files/d" setup.py || die
	distutils-r1_src_prepare
	eapply_user
}

src_compile() {
	if use chipsec-driver; then
		local modlist=( chipsec=misc:drivers/linux )
		local modargs=( KVER="${KV_FULL}" KSRC="${KERNEL_DIR}" )
		linux-mod-r1_src_compile
	fi
	distutils-r1_src_compile
}

src_install() {
	if use chipsec-driver; then
		linux-mod-r1_src_install
	fi
	distutils-r1_src_install
}
