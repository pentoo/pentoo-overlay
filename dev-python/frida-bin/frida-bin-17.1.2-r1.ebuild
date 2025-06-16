# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

PYPI_PN=${PN/-bin/}
inherit distutils-r1 pypi

DESCRIPTION="Dynamic instrumentation toolkit for reverse-engineers and security researchers"
HOMEPAGE="https://github.com/frida/frida"

ABI_AMD64="abi3-manylinux1_x86_64"
ABI_X86="abi3-manylinux1_i686"
ABI_ARM64="abi3-manylinux_2_17_aarch64"

SRC_URI="
	amd64? (
		$(pypi_wheel_url frida "${PV}" cp37 ${ABI_AMD64})
	)
	x86? (
		$(pypi_wheel_url frida "${PV}" cp37 ${ABI_X86})
	)
	arm64? (
		$(pypi_wheel_url frida "${PV}" cp37 ${ABI_ARM64})
	)
"

S="${WORKDIR}/"

LICENSE="wxWinLL-3.1"
SLOT="0"

KEYWORDS="amd64 ~arm64 x86"

RDEPEND="~dev-libs/frida-core-${PV}
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	!dev-python/frida"
DEPEND="${PYTHON_DEPS}"

BDEPEND="app-arch/unzip"

# The QA_WX error is due to frida-core pre-build lib
QA_PREBUILT="usr/lib/python*/site-packages/_frida.abi3.so"

python_compile() {
	if use amd64; then
		MY_WHEEL=$(pypi_wheel_name frida "${PV}" cp37 ${ABI_AMD64})
	fi
	if use x86; then
		MY_WHEEL=$(pypi_wheel_name frida "${PV}" cp37 ${ABI_X86})
	fi
	if use arm64; then
		MY_WHEEL=$(pypi_wheel_name frida "${PV}" cp37 ${ABI_ARM64})
	fi

	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/${MY_WHEEL}"
}
