# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYTHON_REQ_USE="tk"

inherit distutils-r1 git-r3

DESCRIPTION="A module for very simple, very easy GUI programming in Python"
HOMEPAGE="https://easygui.readthedocs.io"
EGIT_REPO_URI="https://github.com/robertlugg/${PN}"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

# can't test, it needs a graphical interface and pynput (not in Gentoo overlay)
RESTRICT="test"

distutils_enable_sphinx sphinx
