# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )
EGO_PN=github.com/bd808/${PN}

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bd808/python-iptools.git"
	KEYWORDS=""
else
#	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="b4398244355d46dae161a791102ed4a0f48e0d83"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="A package is a collection of utilities for dealing with IP addresses."
HOMEPAGE="https://github.com/bd808/python-iptools"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
