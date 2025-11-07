# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

FRIDA_VER="20250512"

DESCRIPTION="Dynamic instrumentation toolkit for reverse-engineers and security researchers"
HOMEPAGE="https://github.com/frida/frida"

SRC_URI+="
	amd64? (
		https://build.frida.re/deps/${FRIDA_VER}/toolchain-linux-x86_64.tar.xz
		https://build.frida.re/deps/${FRIDA_VER}/sdk-linux-x86_64.tar.xz
	)
	x86? (
		https://build.frida.re/deps/${FRIDA_VER}/toolchain-linux-x86.tar.xz
		https://build.frida.re/deps/${FRIDA_VER}/sdk-linux-x86.tar.xz
	)
	arm64? (
		https://build.frida.re/deps/${FRIDA_VER}/toolchain-linux-arm64.tar.xz
		https://build.frida.re/deps/${FRIDA_VER}/sdk-linux-arm64.tar.xz
	)
"

#ARM64E_URL = "https://build.frida.re/deps/{version}/sdk-ios-arm64e.tar.xz"

LICENSE="wxWinLL-3.1"
SLOT="0"

#WiP
#KEYWORDS="amd64 ~arm64 x86"

RDEPEND="~dev-libs/frida-core-${PV}
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	!dev-python/frida-bin"
DEPEND="${PYTHON_DEPS}"

# The QA_WX error is due to frida-core pre-build lib
QA_PREBUILT="usr/lib/python*/site-packages/_frida.abi3.so"

src_unpack() {
	unpack "${P}.tar.gz"

	cd "${S}"
	mkdir -p ./deps || die "failed to create Debugger dir"
	cp -P "${DISTDIR}"/sdk-linux-x86_64.tar.xz ./deps/ || die
	# if use amd64 &&
	cp -P "${DISTDIR}"/toolchain-linux-x86_64.tar.xz ./deps/ || die
}

python_compile() {
	export FRIDA_CORE_DEVKIT="/usr/lib64/"
	distutils-r1_python_compile
}
