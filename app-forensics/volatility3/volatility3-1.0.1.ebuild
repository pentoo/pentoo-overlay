# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

MY_PV=${PV//_beta/-beta.}

DESCRIPTION="Framework for analyzing volatile memory"
HOMEPAGE="https://github.com/volatilityfoundation/volatility3/ https://www.volatilityfoundation.org/"
SRC_URI="https://github.com/volatilityfoundation/volatility3/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jsonschema yara crypto disasm"

S=${WORKDIR}/${PN}-${MY_PV}

RDEPEND="dev-python/pefile[${PYTHON_USEDEP}]
	jsonschema? ( >=dev-python/jsonschema-2.3.0[${PYTHON_USEDEP}] )
	yara? ( >=dev-python/yara-python-3.8.0[${PYTHON_USEDEP}] )
	crypto? ( dev-python/pycryptodome[${PYTHON_USEDEP}] )
	disasm? ( dev-libs/capstone[python,${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
