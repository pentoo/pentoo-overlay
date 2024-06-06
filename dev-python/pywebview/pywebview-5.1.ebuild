# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A lightweight cross-platform wrapper around a webview component"
HOMEPAGE="https://github.com/r0x0r/pywebview"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

# copy USE flags from dev-python/QtPy
IUSE="gtk +pyqt5"
REQUIRED_USE="|| ( gtk pyqt5 )"

RDEPEND="
	dev-python/proxy_tools[${PYTHON_USEDEP}]
	dev-python/bottle[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]

	gtk? (
		dev-python/pygobject[cairo,${PYTHON_USEDEP}]
		net-libs/webkit-gtk
	)
	pyqt5? (
		dev-python/QtPy[${PYTHON_USEDEP},webengine]
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/PyQtWebEngine[${PYTHON_USEDEP}]
	)
	"
#	qt5? (
#		dev-python/pyside2[${PYTHON_USEDEP},webengine]
#		dev-python/QtPy[${PYTHON_USEDEP},webengine]
#	)
#	qt6? (
#		dev-python/pyside6[${PYTHON_USEDEP},webengine]
#		dev-python/QtPy[${PYTHON_USEDEP},webengine]
#	)
#"

distutils_enable_tests pytest

RESTRICT="test" # FIXME: tests fail without message
