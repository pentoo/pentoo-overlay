# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit python-r1

DESCRIPTION="Virtual for Frida"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND="
	${PYTHON_DEPS}
	|| (
		>=dev-python/frida-bin-${PV}[${PYTHON_USEDEP}]
		>=dev-python/frida-${PV}[${PYTHON_USEDEP}]
	)"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
