# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 pypi

DESCRIPTION="Read Android's binary format for XML files (AXML) and a decompiler for DEX"
HOMEPAGE="https://github.com/androguard/androguard"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
# no proper test scripts
#RESTRICT="test"

RDEPEND="
	>=dev-python/pygments-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-0.24.0[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/pydot-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/ipython-5.0.0[${PYTHON_USEDEP}]
	dev-python/mutf8[${PYTHON_USEDEP}]
	dev-python/dataset[${PYTHON_USEDEP}]
	dev-python/frida-python[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	>=dev-util/apkInspector-1.1.7[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
