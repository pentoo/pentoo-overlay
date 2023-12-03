# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# https://bugs.launchpad.net/gcc-arm-embedded/+bug/1949004
#major/update
#MY_PV1="$(ver_cut 1)-$(ver_cut 2)-q$(ver_cut 3)-major"
#MY_PV2="$(ver_cut 1)-$(ver_cut 2)q$(ver_cut 3)"

#AVC=( $(ver_rs 1- ' ') )
#MY_PV="${AVC[0]}.${AVC[1]}-${AVC[3]:0:4}.${AVC[3]:4:5}"

MY_PV="${PV/_p/.rel}"
#MY_PN="${PN/-bin}"

DESCRIPTION="GNU Arm Embedded Toolchain"
HOMEPAGE="https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"

#SRC_SUFFIX="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm"
#SRC_URI="amd64? ( ${SRC_SUFFIX}/${MY_PV2}/gcc-arm-none-eabi--x86_64-linux.tar.bz2 )
#	arm64? ( ${SRC_SUFFIX}/${MY_PV2}/gcc-arm-none-eabi-${MY_PV1}-aarch64-linux.tar.bz2 )"
SRC_URI="amd64? ( https://developer.arm.com/-/media/Files/downloads/gnu/${MY_PV}/binrel/arm-gnu-toolchain-${MY_PV}-x86_64-arm-none-eabi.tar.xz )
	arm64? ( https://developer.arm.com/-/media/Files/downloads/gnu/${MY_PV}/binrel/arm-gnu-toolchain-${MY_PV}-aarch64-arm-none-eabi.tar.xz )"

#need:
# https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-eabi.tar.xz?rev=95edb5e17b9d43f28c74ce824f9c6f10&hash=176C4D884DBABB657ADC2AC886C8C095409547C4
#actual:
# https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/gcc-arm-11.3.rel1-x86_64-arm-none-eabi.tar.xz'

LICENSE="BSD GPL-2 LGPL-2 LGPL-3 MIT NEWLIB ZLIB"
SLOT="0"
KEYWORDS="amd64"
IUSE="python3"
RESTRICT="strip"
QA_PREBUILT="*"

DEPEND=""
RDEPEND="sys-libs/ncurses-compat
	virtual/libcrypt
	dev-libs/expat
		python3? ( =dev-lang/python-3* )"

S=$(echo "${WORKDIR}/arm-gnu-toolchain-${MY_PV}-x86_64-arm-none-eabi" | sed 's/rel/Rel/g')

src_install() {
	dodir /opt/${PN}
	\cp -r "${S}"/* "${ED}"/opt/${PN}
	use python3 || rm "${ED}"/opt/gcc-arm-none-eabi/bin/arm-none-eabi-gdb-py
	fowners -R root:0 /opt/${PN}

	local DEST="${EPREFIX}/opt/${PN}"
	cat > "${T}/env" << EOF
PATH=${DEST}/bin
ROOTPATH=${DEST}/bin
LDPATH=${DEST}/lib
MANPATH=${DEST}/share/doc/arm-arm-none-eabi/man
EOF
	newenvd "${T}/env" 99gcc-arm-embedded-bin

	#tell revdep-rebuild to ignore binaries meant for the target
	dodir /etc/revdep-rebuild
	cat <<-EOF > "${ED}"/etc/revdep-rebuild/99-${P}
		SEARCH_DIRS_MASK="${DEST}"
	EOF
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]] ; then
		elog "Before use you should run 'env-update' and '. /etc/profile'"
		elog "otherwise you may be missing important environmental variables."
	fi
}
