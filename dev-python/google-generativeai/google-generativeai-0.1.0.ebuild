# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python client library for Google's large language model PaLM API"
HOMEPAGE="https://github.com/google/generative-ai-python"
SRC_URI="https://github.com/google/generative-ai-python/archive/refs/tags/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE=""

RESTRICT="test"

RDEPEND="dev-python/google-ai-generativelanguage[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S=${WORKDIR}/generative-ai-python-${PV}
