# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Frida CLI tools"
HOMEPAGE="https://github.com/frida/frida-tools"

LICENSE="wxWinLL-3.1"
SLOT="0"

KEYWORDS="amd64 ~arm64 x86"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/colorama-0.2.7[${PYTHON_USEDEP}]
	|| (
		>=dev-python/frida-bin-17.1.0[${PYTHON_USEDEP}]
		>=dev-python/frida-17.1.0[${PYTHON_USEDEP}]
	)
	>=dev-python/prompt-toolkit-3.0.3[${PYTHON_USEDEP}] <dev-python/prompt-toolkit-4.0.0
	>=dev-python/pygments-2.0.2[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]"

RESTRICT="test"
