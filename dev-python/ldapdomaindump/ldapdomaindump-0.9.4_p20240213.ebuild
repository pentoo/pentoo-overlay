# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Active Directory information dumper via LDAP"
HOMEPAGE="https://github.com/dirkjanm/ldapdomaindump"
COMMIT="50e064b11053b0846d4fb3684429c3b2b0d5c58d"
SRC_URI="https://github.com/dirkjanm/ldapdomaindump/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]"
