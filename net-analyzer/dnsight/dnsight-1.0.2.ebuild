# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="auditing DNS, email authentication (SPF, DKIM, DMARC), and related signals"
HOMEPAGE="https://github.com/dnsight/dnsight"
#SRC_URI="https://github.com/darkoperator/dnsrecon/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/cryptography-43.0.0[${PYTHON_USEDEP}]
	>=dev-python/dnspython-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12.5[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
	>=dev-python/rich-14.3.3[${PYTHON_USEDEP}]
	>=dev-python/typer-0.24.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

#  "pytest>=9.0.2,<10.0.0",
#  "pytest-asyncio>=1.3.0,<2.0.0",
#  "pytest-cov>=7.0.0,<8.0.0",
#  "hypothesis>=6.151.9,<7.0.0",
#  "mutmut>=3.5.0,<4.0.0",

# __main__.py: error: unrecognized arguments: --cov=src/dnsight --cov=tools --cov-report=term-missing --cov-report=xm
#distutils_enable_tests pytest
RESTRICT="test"
