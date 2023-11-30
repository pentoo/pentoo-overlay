# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Kerberos manipulation library in pure Python"
HOMEPAGE="https://github.com/skelsec/minikerberos"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE=""

RDEPEND="
	>=dev-python/asn1crypto-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/oscrypto-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/asysocks-0.2.7[${PYTHON_USEDEP}]
	>=dev-python/unicrypto-0.0.10[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare(){
	rm -r tests
	eapply_user
}
