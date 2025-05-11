# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/edoardottt/takeover.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	HASH_COMMIT="4930498d1533a94a485d1634c5f0e160baa63c28"
	SRC_URI="https://github.com/edoardottt/takeover/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Sub-Domain TakeOver Vulnerability Scanner"
HOMEPAGE="https://github.com/edoardottt/takeover"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
