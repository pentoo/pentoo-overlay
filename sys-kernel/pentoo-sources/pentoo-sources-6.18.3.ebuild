# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="5"

inherit check-reqs kernel-2
detect_version
detect_arch

DESCRIPTION="Pentoo kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
HOMEPAGE="https://github.com/pentoo/pentoo-overlay/tree/master/sys-kernel/pentoo-sources"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"
KEYWORDS="amd64 arm arm64 x86"
IUSE="experimental footgun +lts"

pkg_pretend() {
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_pretend
}

src_prepare() {
	kernel-2_src_prepare
	rm "${S}/tools/testing/selftests/tc-testing/action-ebpf"
}

src_unpack() {
	# default
	kernel-2_src_unpack
	# penpatches
	eapply -s "${FILESDIR}/4004_zd1211rw-inject+dbi-fix-4.7ish.patch"
	# I don't really think these are needed, but they are both safe so we will apply by default
	eapply -s "${FILESDIR}/4006_kali-wifi-injection-safe.patch"
	eapply -s "${FILESDIR}/4007_kali-wifi-injection-rtl8187.patch"
	# End kali patches
	eapply -s "${FILESDIR}/4400_logo_larry_the_cow.patch"
	if use footgun; then
		# This patch is totally unsafe and simply removes the safety checks preventing the user from
		# changing channels when it would break things.
		eapply -s "${FILESDIR}/4005_kali-wifi-injection-unsafe.patch"
	fi
}

src_install() {
	kernel-2_src_install
	insinto /usr/share/${PN}
	if use amd64; then
		doins "${FILESDIR}"/config-amd64-${PVR}
	elif use x86; then
		doins "${FILESDIR}"/config-x86-${PVR}
	fi
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	ewarn "The official pentoo kernel config is now installed with the kernel in /usr/share/pentoo-sources"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
