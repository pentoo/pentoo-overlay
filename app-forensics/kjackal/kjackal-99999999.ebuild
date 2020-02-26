# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# FIXME: this is package is no longer support
# alternative: app-forensics/prochunter

EAPI=7

inherit git-r3 linux-mod

DESCRIPTION="Linux Rootkit Scanner"
HOMEPAGE="https://github.com/dgoulet/kjackal"
SRC_URI=""

EGIT_REPO_URI="https://github.com/dgoulet/kjackal"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="ad45c330a37ae607144bd0fedad15a1304f2542d"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup() {
	if use kernel_linux; then
		MODULE_NAMES="${PN}(misc:${S}:${S})"
		BUILD_TARGETS="clean default"

		linux-mod_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare() {
	# Author of patch: can't really test it because arch doesn't provide 
	#                  system.map anymore, but at least someone else can 
	#                  get to use it, I guess
	if ver_test "$(ver_cut 1-2 ${KV_FULL})" -ge "3.15"; then
		eapply "${FILESDIR}"/port_to_modern_kernel_api.patch
	fi

	eapply_user
}

src_compile() {
	if use kernel_linux; then
		MAKEOPTS="-j1" linux-mod_src_compile
	fi
}

src_install() {
	use kernel_linux && linux-mod_src_install
	dodoc README THANKS TODO AUTHORS
}

pkg_postinst() {
	use kernel_linux && linux-mod_pkg_postinst
	einfo "\nUSAGE:"
	einfo "    ~# insmod kjackal.ko"
	einfo "    ~# dmesg"
	einfo "Kjackal prints the report in dmesg."
	einfo "    ~# rmmod kjackal\n"
}
