# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A Frida based tool that traces usage of the JNI API in Android apps."
HOMEPAGE="https://github.com/chame1eon/jnitrace"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=">=dev-python/frida-python-14.0.5[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/hexdump[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

#FIXME: add https://github.com/chame1eon/jnitrace-engine
