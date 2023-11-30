# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A tool to translate between different languages"
HOMEPAGE="https://github.com/nidhaloff/deep-translator"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="docx pypdf openai"

RDEPEND="
	>=dev-python/beautifulsoup4-4.9.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.23.0[${PYTHON_USEDEP}]

	docx? ( app-text/docx2txt )
	pypdf? ( dev-python/pypdf[${PYTHON_USEDEP}] )
	openai? ( dev-python/openai[${PYTHON_USEDEP}] )
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
