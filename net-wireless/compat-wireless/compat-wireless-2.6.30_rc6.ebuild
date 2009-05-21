# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"
MY_P=${P/_rc/-rc}
SRC_URI="http://www.orbit-lab.org/kernel/compat-wireless-2.6-stable/v2.6.30/${MY_P}.tar.bz2"

inherit linux-mod

#This doesn't seem to work because it doesn't cry about athload being a blocker
PROVIDES="net-wireless/athload"
DEPENDS="!net-wireless/athload"
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
    epatch "${FILESDIR}"/whynot.patch
    addpredict "${KERNEL_DIR}"
#    addpredict /lib/modules/"${KV_FULL}"
#    die "build your patch"
    emake || die "emake failed"
#    linux-mod_src_compile
}

src_install() {
#    addpredict "${KERNEL_DIR}"
#    addpredict /lib/modules/"${KV_FULL}"
##XXX: This filthy hack should not be allowed to exist
    addwrite /lib/modules/${KV_FULL}/modules.dep.temp
    addwrite /lib/modules/${KV_FULL}/modules.dep
    addwrite /lib/modules/${KV_FULL}/modules.pcimap.temp
    addwrite /lib/modules/${KV_FULL}/modules.pcimap
    addwrite /lib/modules/${KV_FULL}/modules.usbmap.temp
    addwrite /lib/modules/${KV_FULL}/modules.usbmap
    addwrite /lib/modules/${KV_FULL}/modules.ccwmap.temp
    addwrite /lib/modules/${KV_FULL}/modules.ccwmap
    addwrite /lib/modules/${KV_FULL}/modules.ieee1394map.temp
    addwrite /lib/modules/${KV_FULL}/modules.ieee1394map
    addwrite /lib/modules/${KV_FULL}/modules.isapnpmap.temp
    addwrite /lib/modules/${KV_FULL}/modules.isapnpmap
    addwrite /lib/modules/${KV_FULL}/modules.inputmap.temp
    addwrite /lib/modules/${KV_FULL}/modules.inputmap
    addwrite /lib/modules/${KV_FULL}/modules.ofmap.temp
    addwrite /lib/modules/${KV_FULL}/modules.ofmap
    addwrite /lib/modules/${KV_FULL}/modules.seriomap.temp
    addwrite /lib/modules/${KV_FULL}/modules.seriomap
    addwrite /lib/modules/${KV_FULL}/modules.alias.temp
    addwrite /lib/modules/${KV_FULL}/modules.alias
    addwrite /lib/modules/${KV_FULL}/modules.symbols.temp
    addwrite /lib/modules/${KV_FULL}/modules.symbols
##/XXX
    emake DESTDIR="${D}" install || die "install failed"
#    linux-mod_src_install
    dodoc README || die
}

pkg_postinst() {
#        local moddir="${ROOT}/lib/modules/${KV_FULL}/updates/"

#        linux-mod_pkg_postinst
	/sbin/depmod -ae
}
