# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="vendor and platform neutral SDR support library"
HOMEPAGE="https://github.com/xmikos/qspectrumanalyzer"

LICENSE="GPL-3"
SLOT="0"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xmikos/qspectrumanalyzer.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/xmikos/qspectrumanalyzer/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
# The depend on soapy_power can be removed if patched out of setup.py
RDEPEND="${DEPEND}
	net-wireless/soapy_power[${PYTHON_USEDEP}]
	dev-python/pyqtgraph[${PYTHON_USEDEP}]
	dev-python/qt-py[${PYTHON_USEDEP}]"
