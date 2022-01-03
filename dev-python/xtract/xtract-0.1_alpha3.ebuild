# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Library to (un)pack archives and (de)compress files"
HOMEPAGE="https://rolln.de/knoppo/xtract"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-0.1a3.tar.gz"
#534f7ca1c47faf47dec147533b94433a13d/xtract-0.1a3.tar.gz

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-python/python-magic[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/xtract-0.1a3"
