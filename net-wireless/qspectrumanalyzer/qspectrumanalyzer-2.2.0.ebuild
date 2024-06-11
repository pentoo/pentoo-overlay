# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#PYPI_NO_NORMALIZE=1
#PYPI_PN="QSpectrumAnalyzer"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="vendor and platform neutral SDR support library"
HOMEPAGE="https://github.com/xmikos/qspectrumanalyzer"
SRC_URI="https://github.com/xmikos/qspectrumanalyzer/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
# The depend on soapy_power can be removed if patched out of setup.py
RDEPEND="${DEPEND}
	net-wireless/soapy_power[${PYTHON_USEDEP}]
	dev-python/pyqtgraph[${PYTHON_USEDEP}]
	dev-python/qt-py[${PYTHON_USEDEP}]"
