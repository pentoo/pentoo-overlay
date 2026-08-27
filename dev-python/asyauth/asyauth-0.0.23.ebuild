# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="asyauth by skilsec"
HOMEPAGE="https://github.com/skelsec/asyauth"
SRC_URI="https://github.com/skelsec/asyauth/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

# https://github.com/skelsec/asyauth/pull/15
PATCHES=(
	"${FILESDIR}"/"${P}"-string-test.patch
)

RDEPEND="
	>=dev-python/unicrypto-0.0.12[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.18[${PYTHON_USEDEP}]
	>=dev-python/minikerberos-0.4.9[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	epytest asyauth/tests/url.py
}
