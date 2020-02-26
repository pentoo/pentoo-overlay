# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python library using ctypes to search/edit programs memory"
HOMEPAGE="https://github.com/n1nj4sec/memorpy"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/n1nj4sec/memorpy"
else
	#snapshot
	HASH_COMMIT="adcc002045a6db29f2d3f3b5666fb4a90bab1bd5"
	SRC_URI="https://github.com/n1nj4sec/memorpy/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
DEPEND=""
RDEPEND="${PYTHON_DEPS}"
