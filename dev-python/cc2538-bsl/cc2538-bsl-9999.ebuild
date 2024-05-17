# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 git-r3

DESCRIPTION="upload firmware via the serial boot loader onto the CC13xx, CC2538 and CC26xx"
HOMEPAGE="https://github.com/JelmerT/cc2538-bsl"
# Using a fork for sonoff support
# https://github.com/JelmerT/cc2538-bsl/pull/168
# https://github.com/JelmerT/cc2538-bsl/pull/173
EGIT_REPO_URI="https://github.com/sultanqasim/cc2538-bsl.git"

LICENSE="BSD-3"
SLOT="0"

RDEPEND="
	dev-python/intelhex
	dev-python/python-magic
"
BDEPEND="test? ( dev-python/scripttest )"

distutils_enable_tests pytest
