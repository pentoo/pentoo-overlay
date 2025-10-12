# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/BC-SECURITY/PySecretSOCKS.git"
else
	EGIT_COMMIT="43c0beda33d5f7939d2a434a873b36fc395f6204"
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
