# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"

##Stable
MY_P=${P/_rc/-rc}
SRC_URI="http://www.orbit-lab.org/kernel/compat-wireless-2.6-stable/v2.6.30/${MY_P}.tar.bz2"

##Dailies
#MY_P=${P//./-}
#SRC_URI="http://wireless.kernel.org/download/compat-wireless-2.6/${MY_P}.tar.bz2"

inherit linux-mod linux-info

DEPEND="=sys-kernel/linux-firmware-99999999"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="kernel_linux +injection"

S=${WORKDIR}/${MY_P}
CONFIG_CHECK="!DYNAMIC_FTRACE"
RESTRICT="strip"

pkg_setup() {
	linux-mod_pkg_setup
	linux_chkconfig_module MAC80211 || die "CONFIG_MAC80211 must be built as a _module_ !"
	linux_chkconfig_module CFG80211 || die "CONFIG_CFG80211 must be built as a _module_ !"
}

src_compile() {
	if use injection; then epatch "${FILESDIR}"/400[024]_*.patch; fi
#	if use injection; then epatch "${FILESDIR}"/4012_*.patch; fi
	epatch "${FILESDIR}"/whynot-2.6.31.patch
	epatch "${FILESDIR}"/rtl8187-led-blink_possibly-final.patch
	addpredict "${KERNEL_DIR}"
#    addpredict /lib/modules/"${KV_FULL}"
#	sed -e 's/(MAKE)/(MAKE) ARCH=$(ARCH)/g' -i Makefile
	use amd64 && export ARCH="x86_64"
	use x86 && export ARCH="x86"
	emake KVER="${KV_FULL}" || die "emake failed"
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
	update_depmod
}
