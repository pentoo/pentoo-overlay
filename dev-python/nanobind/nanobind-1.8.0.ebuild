# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="tiny and efficient C++/Python bindings"
HOMEPAGE="https://github.com/wjakob/nanobind"
SRC_URI="https://github.com/wjakob/nanobind/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="dev-cpp/robin-map"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

src_prepare(){
	#fool cmake script to use external module
	mkdir -p ext/robin_map/include
	eapply_user
}
