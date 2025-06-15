# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYTHON_REQ_USE="tk"

COMMIT="b113a76c503c86e2171fe765ed4bf1c2c226f1eb"

inherit distutils-r1

DESCRIPTION="A module for very simple, very easy GUI programming in Python"
HOMEPAGE="https://easygui.readthedocs.io"
SRC_URI="https://github.com/robertlugg/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

# can't test, it needs a graphical interface and pynput (not in Gentoo overlay)
RESTRICT="test"

distutils_enable_sphinx sphinx
