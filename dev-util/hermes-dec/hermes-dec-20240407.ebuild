# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="decompiling and disassembling the React Native Hermes bytecode"
HOMEPAGE="https://github.com/P1sec/hermes-dec"
HASH_COMMIT="7c9d95841e2afae03b9812c64f826ef9ae7ebae7"
SRC_URI="https://github.com/P1sec/hermes-dec/archive/${HASH_COMMIT}.tar.gz  -> ${P}.gh.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
RESTRICT="test"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
