# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod git-r3 flag-o-matic

DESCRIPTION="Modified usb wifi driver for TP_link TL-WDN5200"
HOMEPAGE="https://github.com/chenhaiq/mt7610u_wifi_sta_v3002_dpo_20130916.git"
EGIT_REPO_URI="https://github.com/ulli-kroll/mt7610u.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

MODULE_NAMES="mt7610u_sta(net/wireless:)"
BUILD_TARGETS="clean modules"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KSRC=${KV_DIR}"
}

src_prepare() {
	default
	sed -i "s#/lib/modules/\$(shell uname -r)#/lib/modules/${KV_FULL}#" Makefile
}

src_compile() {
	set_arch_to_kernel
	append-flags -Wno-error=designated-init
	WFLAGS="${CFLAGS}" emake V=1
}

src_install() {
  linux-mod_src_install

  insinto /etc/Wireless/RT2870STA/
  doins RT2870STA.dat
}
