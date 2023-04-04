# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

DISTUTILS_USE_PEP517=poetry
inherit distutils-r1
distutils_enable_tests pytest

DESCRIPTION="A rate limiting extension for Starlette and Fastapi"
HOMEPAGE="https://github.com/laurents/slowapi"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/laurentS/slowapi/archive/8f8fc7c65a57fd8fcfd476ff1e782bd37f4eed8f.tar.gz -> ${P}.tar.gz"
inherit vcs-snapshot

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
#RESTRICT="!test? ( test )"
#doesn't seem to work, missing "hiro"?
RESTRICT=test

BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"
RDEPEND=">=dev-python/limits-1.5[${PYTHON_USEDEP}]
	>=dev-python/redis-3.4.1[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
