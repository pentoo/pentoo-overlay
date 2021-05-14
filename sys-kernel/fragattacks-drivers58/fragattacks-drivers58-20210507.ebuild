# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#copy more hacks from compat-drivers-3.8-r1.ebuild

EAPI=7

inherit linux-mod linux-info

DESCRIPTION=""
HOMEPAGE="https://github.com/aircrack-ng/rtl8812au"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vanhoefm/fragattacks-drivers58.git"
#	EGIT_BRANCH="v5.6.4.2"
else
	HASH_COMMIT="92453e8ab9cf1db26fca29aa0155870f6bdd2bf9"
	SRC_URI="https://github.com/vanhoefm/fragattacks-drivers58/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/fragattacks-drivers58-${HASH_COMMIT}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

DEPEND="
	!!net-wireless/rtl8812au
	!!net-wireless/rtl8812au_asus
	!!net-wireless/rtl8812au_astsam"

#pkg_setup() {
#		linux-mod_pkg_setup
#		ARCH=x86_64
#		BUILD_PARAMS="kver=${KV_FULL} V=1"
#}

src_prepare() {
	eapply -p0 "${FILESDIR}/Makefile_kver.patch"
	eapply_user

	#see /defconfigs
#	emake kver="{KV_FULL}" defconfig-wifi
#	emake kver="{KV_FULL}" defconfig-experiments
#	emake kver="{KV_FULL}" defconfig-b43
	#rtl88x cards
	emake kver="{KV_FULL}" defconfig-rtlwifi

}

src_compile() {
	addpredict "${KERNEL_DIR}"
	set_arch_to_kernel
	emake KLIB_BUILD="${DESTDIR}"/lib/modules/"${KV_FULL}"/build || die "emake failed"
#	emake
}

src_install() {
	for file in $(find -name \*.ko); do
		insinto "/lib/modules/${KV_FULL}/updates/$(dirname ${file})"
		doins "${file}"
	done
}
