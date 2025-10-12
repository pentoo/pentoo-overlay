# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit python-r1

MY_PV="${PV/_p/.rel}"

DESCRIPTION="GNU Arm Embedded Toolchain"
HOMEPAGE="https://developer.arm.com/open-source/gnu-toolchain/gnu-rm"

SRC_URI="amd64? ( https://developer.arm.com/-/media/Files/downloads/gnu/${MY_PV}/binrel/arm-gnu-toolchain-${MY_PV}-x86_64-arm-none-eabi.tar.xz )
	arm64? ( https://developer.arm.com/-/media/Files/downloads/gnu/${MY_PV}/binrel/arm-gnu-toolchain-${MY_PV}-aarch64-arm-none-eabi.tar.xz )"

if [[ "${ARCH}" = "amd64" ]]; then
	S="${WORKDIR}/arm-gnu-toolchain-${MY_PV}-x86_64-arm-none-eabi"
elif [[ "${ARCH}" = "arm64" ]]; then
	S="${WORKDIR}/arm-gnu-toolchain-${MY_PV}-aarch64-arm-none-eabi"
fi

LICENSE="BSD GPL-2 LGPL-2 LGPL-3 MIT NEWLIB ZLIB"
SLOT="0"
KEYWORDS="amd64"
IUSE="python"
RESTRICT="strip"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
QA_PREBUILT="*"

RDEPEND="sys-libs/ncurses-compat:5
	virtual/libcrypt
	dev-libs/expat
	python? ( ${PYTHON_DEPS} )"

src_install() {
	dodir /opt/${PN}
	cp -r "${S}"/* "${ED}"/opt/${PN}
	use python || rm "${ED}"/opt/gcc-arm-none-eabi/bin/arm-none-eabi-gdb-py
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
