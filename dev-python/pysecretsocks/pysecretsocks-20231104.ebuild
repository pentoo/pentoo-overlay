# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/BC-SECURITY/PySecretSOCKS.git"
else
	EGIT_COMMIT="da5be0e48f82097044894247343cef2111f13c7a"
	SRC_URI="https://github.com/BC-SECURITY/PySecretSOCKS/archive/${EGIT_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="amd64 ~arm64 x86"
	S="${WORKDIR}/PySecretSOCKS-${EGIT_COMMIT}"
fi

DESCRIPTION="A python SOCKS server for tunneling connections over another channel."
HOMEPAGE="https://github.com/BC-SECURITY/PySecretSOCKS"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
