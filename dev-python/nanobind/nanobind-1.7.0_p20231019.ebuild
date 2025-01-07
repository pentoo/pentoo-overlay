# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="tiny and efficient C++/Python bindings"
HOMEPAGE="https://github.com/wjakob/nanobind"
#this fork is specifically required by LIEF project
SRC_URI="https://github.com/lief-project/LIEF/raw/bb2bd6c679644f075d1dc92b8c2c2a222d4154ed/third-party/nanobind-1.7.0.r7.gfd1f04b.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="dev-cpp/robin-map"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

S="${WORKDIR}"
