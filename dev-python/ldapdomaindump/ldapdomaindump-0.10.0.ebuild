# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Active Directory information dumper via LDAP"
HOMEPAGE="https://github.com/dirkjanm/ldapdomaindump"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PV}_73.patch" )

src_prepare(){
	#https://github.com/dirkjanm/ldapdomaindump/issues/74
	rm setup.py || die "unable to remove setup.py"

	default
}
