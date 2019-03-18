# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/liftoff/${PN}

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )
inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/liftoff/pyminifier.git"
	KEYWORDS=""
else
#        KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="087ea7b0c8c964f1f907c3f350f5ce281798db86"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Pyminifier is a Python code minifier, obfuscator, and compressor."
HOMEPAGE="https://github.com/liftoff/pyminifier"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
