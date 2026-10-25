# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

GITHUB_REPOSITORY="dirkjanm/adidnsdump"
inherit distutils-r1 github-archive

DESCRIPTION="Active Directory Integrated DNS dumping by any authenticated user"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/impacket[${PYTHON_USEDEP}]
	>=dev-python/ldap3-2.9.1[${PYTHON_USEDEP}]
	dev-python/ldap3-ad-auth[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
