# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mschwager/fierce.git"
else
	SRC_URI="https://github.com/mschwager/fierce/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm ~arm64 ~x86"
fi

DESCRIPTION="A DNS reconnaissance tool for locating non-contiguous IP space"
HOMEPAGE="https://github.com/mschwager/fierce"
LICENSE="GPL-2"
SLOT="0"

#/etc/resolv.conf doesn't exist,
RESTRICT="test"

RDEPEND="dev-python/dnspython[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
#	dev-python/setuptools[${PYTHON_USEDEP}]"
#	test? ( dev-python/pytest
#		dev-python/pyfakefs )"

#distutils_enable_tests pytest
