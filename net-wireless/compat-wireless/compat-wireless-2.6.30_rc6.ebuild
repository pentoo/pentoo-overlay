# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"
MY_P=${P/_rc/-rc}
SRC_URI="http://www.orbit-lab.org/kernel/compat-wireless-2.6-stable/v2.6.30/${MY_P}.tar.bz2"

inherit linux-mod linux-info

#This doesn't seem to work because it doesn't cry about athload being a blocker
#PROVIDES="net-wireless/athload"
#DEPENDS="!net-wireless/athload"
#this concern is secondary to the morbid sandbox violations

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="kernel_linux"

S=${WORKDIR}/${MY_P}

#BUILD_TARGETS="all"
#MODULE_NAMES="${PN}(:${S}:${S})"
#MODULESD_COMPAT-WIRELESS_DOCS="README"

#pkg_setup() {
#    linux-mod_pkg_setup
#}

src_compile() {
	addpredict "${KERNEL_DIR}"
	epatch "${FILESDIR}"/whynot.patch
#    addpredict /lib/modules/"${KV_FULL}"
#    die "build your patch"
#	sed -e 's/(MAKE)/(MAKE) ARCH=$(ARCH)/g' -i Makefile
	use amd64 && export ARCH="x86_64"
	use x86 && export ARCH="x86"
	emake || die "emake failed"
#    linux-mod_src_compile
}

src_install() {
	dodir /lib/modules/${KV_FULL}/updates
	emake DESTDIR="${D}" KMODDIR_ARG="INSTALL_MOD_DIR=updates" KMODPATH_ARG="INSTALL_MOD_PATH=${D}" install || die "install failed"
	dodoc README || die
}

pkg_postinst() {
#        local moddir="${ROOT}/lib/modules/${KV_FULL}/updates/"

#        linux-mod_pkg_postinst
	update_depmod
}
