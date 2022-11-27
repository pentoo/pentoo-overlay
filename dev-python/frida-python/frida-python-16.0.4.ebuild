# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

MY_PN="frida"

DESCRIPTION="Dynamic instrumentation toolkit for reverse-engineers and security researchers"
HOMEPAGE="https://github.com/frida/frida"
# copy link from: https://pypi.org/pypi/frida/json
SRC_URI="https://files.pythonhosted.org/packages/24/d0/b2c9bf9726a91a951d3f8acc71584444eff0e3eb39f1bc03c7b332eb5702/frida-16.0.4.tar.gz"

#mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz
#	amd64? (
#		https://files.pythonhosted.org/packages/3.8/f/frida/frida-${PV}-py3.8-linux-x86_64.egg
#	)
#	x86? (
#		https://files.pythonhosted.org/packages/3.8/f/frida/frida-${PV}-py3.8-linux-i686.egg
#	)
#	arm64? (
#		https://files.pythonhosted.org/packages/3.6/f/frida/frida-${PV}-py3.6-linux-aarch64.egg
#	)"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="dev-libs/frida-core"
DEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/${MY_PN}-${PV}"

python_compile() {
	export FRIDA_CORE_DEVKIT="/usr/lib64/"
	distutils-r1_python_compile
}
#python_compile() {
#	export TORCH_CUDA_ARCH_LIST="compute capability"
	# breaks with parallel build
	# need to avoid dropping .so plugins into
	# build-lib, which breaks tests
#	esetup.py build_ext --inplace
	# --cpp_ext --cuda_ext build_ext --inplace -j1
#	TORCH_CUDA_ARCH_LIST="compute capability" distutils-r1_python_compile -j1
#	distutils-r1_python_compile -j1
#}
