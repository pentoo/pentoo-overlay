# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit linux-mod linux-info versionator

##Stable
MY_P=${P/_rc/-rc}
MY_PV=v$(get_version_component_range 1-3)
DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"
SRC_URI="http://www.orbit-lab.org/kernel/${PN}-2.6-stable/${MY_PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="injection"

DEPEND=""
RDEPEND="=sys-kernel/linux-firmware-99999999"

S=${WORKDIR}/${MY_P}
RESTRICT="strip"

CONFIG_CHECK="!DYNAMIC_FTRACE"

pkg_setup() {
	linux-mod_pkg_setup
	kernel_is -lt 2 6 27 && die "kernel 2.6.27 or higher is required for compat wireless to be installed"
	kernel_is -ge $(get_version_component_range 1) $(get_version_component_range 2) $(get_version_component_range 3) && die "The version of compat-wireless you are trying to install contains older modules than your kernel. Failing before downgrading your system."
	linux_chkconfig_module MAC80211 || die "CONFIG_MAC80211 must be built as a _module_ !"
	linux_chkconfig_module CFG80211 || die "CONFIG_CFG80211 must be built as a _module_ !"
}

src_prepare() {
	#whynot patch is against the makefile to fix general brokeness
	epatch "${FILESDIR}"/whynot-2.6.32.patch

	if use injection; then
		epatch "${FILESDIR}"/400[24]_*.patch
		epatch "${FILESDIR}"/mac80211.compat08082009.wl_frag+ack_v1.patch
		epatch "${FILESDIR}"/4013-runtime-enable-disable-of-mac80211-packet-injection.patch
		epatch "${FILESDIR}"/compat-chaos.patch;
		epatch "${FILESDIR}"/rtl8187-mac80211-injection-speed-2.6.30-rc3.patch
	fi
}

src_compile() {
	addpredict "${KERNEL_DIR}"
	set_arch_to_kernel
	emake KVER="${KV_FULL}" || die "emake failed"
}

src_install() {
	for file in $(find -name \*.ko); do
		insinto "/lib/modules/${KV_FULL}/updates/$(dirname ${file})"
		doins "${file}" || die "failed to install module ${file}"
	done
	dosbin scripts/athenable scripts/b43load scripts/iwl-enable \
		scripts/madwifi-unload scripts/athload scripts/iwl-load \
		scripts/b43enable scripts/load.sh \
		scripts/unload.sh || die "script installation failed"

	dodir /usr/lib/compat-wireless
	exeinto /usr/lib/compat-wireless
	doexe scripts/modlib.sh || die

	dodoc README || die
	dodir /$(get_libdir)/udev/rules.d/
	insinto /$(get_libdir)/udev/rules.d/
	doins udev/50-compat_firmware.rules
	exeinto /$(get_libdir)/udev/
	doexe udev/compat_firmware.sh 
}

pkg_postinst() {
	update_depmod
	update_moduledb
	einfo 'You may have problem if you do not run "depmod -ae" after this installation'
	einfo 'To switch to the new drivers without reboot run unload.sh then load.sh'
}

pkg_postrm() {
	remove_moduledb
}
