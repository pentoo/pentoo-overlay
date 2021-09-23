# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#major/update
MY_PV1="$(ver_cut 1)-$(ver_cut 2)-q$(ver_cut 3)-major"
MY_PV2="$(ver_cut 1)-$(ver_cut 2)q$(ver_cut 3)"

DESCRIPTION="GNU Arm Embedded Toolchain"
HOMEPAGE="https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"

SRC_SUFFIX="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm"
SRC_URI="amd64? ( ${SRC_SUFFIX}/${MY_PV2}/gcc-arm-none-eabi-${MY_PV1}-x86_64-linux.tar.bz2 )
	arm64? ( ${SRC_SUFFIX}/${MY_PV2}/gcc-arm-none-eabi-${MY_PV1}-aarch64-linux.tar.bz2 )"

LICENSE="BSD GPL-2 LGPL-2 LGPL-3 MIT NEWLIB ZLIB"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="strip"
QA_PREBUILT="*"

DEPEND=""
RDEPEND="sys-libs/ncurses-compat
		dev-lang/python:2.7"

S="${WORKDIR}/${PN}-${MY_PV1}"

src_install() {
	dodir /opt/${PN}
	\cp -r "${S}"/* "${ED}"/opt/${PN}
	fowners -R root:0 /opt/${PN}

	local DEST=/opt/${PN}
	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/lib
MANPATH=${DEST}/share/doc/arm-arm-none-eabi/man
EOF
	newenvd "${T}/env" 99gcc-arm-embedded-bin
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]] ; then
		elog "Before use you should run 'env-update' and '. /etc/profile'"
		elog "otherwise you may be missing important environmental variables."
	fi
}
