# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Reverse Engineered ChatGPT API by OpenAI"
HOMEPAGE="https://github.com/acheong08/ChatGPT"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/acheong08/ChatGPT/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#FIXME: missing deps
#KEYWORDS="amd64 ~arm64 x86"
#>=dev-python/tiktoken-0.3.0[${PYTHON_USEDEP}]
#>=dev-python/OpenAIAuth-0.3.2[${PYTHON_USEDEP}]

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/openai[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/ChatGPT-${PV}"
