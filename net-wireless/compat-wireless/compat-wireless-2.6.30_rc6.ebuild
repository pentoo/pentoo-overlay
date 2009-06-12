# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"
MY_P=${P/_rc/-rc}
SRC_URI="http://www.orbit-lab.org/kernel/compat-wireless-2.6-stable/v2.6.30/${MY_P}.tar.bz2"

inherit linux-mod linux-info

DEPEND=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="kernel_linux +injection"

S=${WORKDIR}/${MY_P}
CONFIG_CHECK="!DYNAMIC_FTRACE"
RESTRICT="strip"

#BUILD_TARGETS="all"
#MODULE_NAMES="ImaModule(updates/blah:srctreelocation:srctreelocationofko)"

##Adding the following for reference only while writing, remove after it works (the right way)
# The structure of each MODULE_NAMES entry is as follows:
#
#   modulename(libdir:srcdir:objdir)
#
# where:
#
#   modulename = name of the module file excluding the .ko
#   libdir     = place in system modules directory where module is installed (by default it's misc)
#   srcdir     = place for ebuild to cd to before running make (by default it's ${S})
#   objdir     = place the .ko and objects are located after make runs (by default it's set to srcdir)
#
# To get an idea of how these variables are used, here's a few lines
# of code from around line 540 in this eclass:
#
#       einfo "Installing ${modulename} module"
#       cd ${objdir} || die "${objdir} does not exist"
#       insinto /lib/modules/${KV_FULL}/${libdir}
#       doins ${modulename}.${KV_OBJ} || die "doins ${modulename}.${KV_OBJ} failed"
#
# For example:
#   MODULE_NAMES="module_pci(pci:${S}/pci:${S}) module_usb(usb:${S}/usb:${S})"
#
# what this would do is
#
#   cd "${S}"/pci
#   make ${BUILD_PARAMS} ${BUILD_TARGETS}
#   cd "${S}"
#   insinto /lib/modules/${KV_FULL}/pci
#   doins module_pci.${KV_OBJ}

##remove the proceeding after this works "the gentoo way"

##the following line is garbage
#MODULESD_COMPAT-WIRELESS_DOCS="README"

pkg_setup() {
	linux-mod_pkg_setup
	linux_chkconfig_module MAC80211 || die "CONFIG_MAC80211 must be built as a _module_ !"
	linux_chkconfig_module CFG80211 || die "CONFIG_CFG80211 must be built as a _module_ !"
}

src_compile() {
	if use injection; then epatch "${FILESDIR}"/40??_*.patch; fi
	epatch "${FILESDIR}"/whynot.patch
#	epatch "${FILESDIR}"/rtl8187-led-blink_possibly-final.patch
	addpredict "${KERNEL_DIR}"
#    addpredict /lib/modules/"${KV_FULL}"
#    die "build your patch"
#	sed -e 's/(MAKE)/(MAKE) ARCH=$(ARCH)/g' -i Makefile
	use amd64 && export ARCH="x86_64"
	use x86 && export ARCH="x86"
	emake KVER="${KV_FULL}" || die "emake failed"
#    linux-mod_src_compile
}

src_install() {
        for file in `find ./ -name \*.ko`
        do
		MY_DIR="/lib/modules/${KV_FULL}/updates/$(dirname ${file})"
		dodir "${MY_DIR}"
		insinto "${MY_DIR}"
                doins "${file}"
        done

#	dodir /lib/modules/${KV_FULL}/updates
#	emake KVER="${KV_FULL}" DESTDIR="${D}" KMODDIR_ARG="INSTALL_MOD_DIR=updates" KMODPATH_ARG="INSTALL_MOD_PATH=${D}" install || die "install failed"
	dodoc README || die
}

pkg_postinst() {
#        local moddir="${ROOT}/lib/modules/${KV_FULL}/updates/"

#        linux-mod_pkg_postinst
	update_depmod
}
