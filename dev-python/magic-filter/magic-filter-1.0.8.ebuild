# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Magic filter based on dynamic attribute getter"
HOMEPAGE="https://github.com/aiogram/magic-filter/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
