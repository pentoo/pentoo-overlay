# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

MY_PV=${PV/_/-}

DESCRIPTION="A tool to enumerate information from NTLM authentication enabled web endpoints"
HOMEPAGE="https://github.com/sachinkamath/NTLMRecon"
SRC_URI="https://github.com/sachinkamath/NTLMRecon/archive/v.${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/python-iptools[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/NTLMRecon-v.${MY_PV}"
