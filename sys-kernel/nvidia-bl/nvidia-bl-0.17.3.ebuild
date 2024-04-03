# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

MY_PN="${PN}-dkms"

DESCRIPTION="Driver to adjust display backlight on legacy mobile NVidia graphics adapters"
HOMEPAGE="https://aur.archlinux.org/packages/nvidia-bl-dkms"
SRC_URI="https://dev.pentoo.ch/~blshkv/distfiles/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

#WIP
#KEYWORDS="~amd64 ~arm64 ~x86"

S="${WORKDIR}/${MY_PN}"

MODULE_NAMES="nvidia_bl(misc:)"
# / extra
BUILD_TARGETS="default"

pkg_setup() {
	linux-mod_pkg_setup
#	kernel_is -ge 3 10 && die "kernel 3.10.0 or higher is not supported by this version"
	BUILD_PARAMS="-C ${KV_DIR} SUBDIRS=${S} KDIR=${KV_DIR} KVER=${KV_FULL} V=1"
}

src_prepare() {
	#FIXME: https://docs.kernel.org/kbuild/modules.html
	eapply "${FILESDIR}"/kernel5.patch
	sed -i 's/__devinitconst//g' nvidia_bl.c
	eapply_user
}

#src_install() {
#	linux-mod_src_install
#}
