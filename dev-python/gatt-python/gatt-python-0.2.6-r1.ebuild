# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Bluetooth GATT SDK for Python"
HOMEPAGE="https://github.com/getsenic/gatt-python"
SRC_URI="https://github.com/getsenic/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="amd64 arm64 x86"
SLOT="0"

RDEPEND="
		net-wireless/bluez
		dev-python/pygobject[${PYTHON_USEDEP}]
"
