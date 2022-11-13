# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Full-featured Telegram client library"
HOMEPAGE="https://github.com/LonamiWebs/Telethon/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND="dev-python/pyaes[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]"
#extra? dev-python/cryptg[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
