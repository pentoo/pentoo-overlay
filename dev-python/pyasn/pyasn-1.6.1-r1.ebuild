# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1

# 1.6.1 was re-packaged; drop -re in next version
MY_PV="${PV/_beta/b}-re"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Python IP address to Autonomous System Number lookup module"
HOMEPAGE="https://github.com/hadiasghari/pyasn"
SRC_URI="https://github.com/hadiasghari/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RESTRICT="test"

IUSE=""

S=${WORKDIR}/${MY_P}
