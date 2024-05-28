# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
PYTHON_REQ_USE="xml(+)"
#DISTUTILS_USE_SETUPTOOLS=no

inherit distutils-r1 prefix

DESCRIPTION="Collection of Gentoo-specific tools for Java"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Java"
SRC_URI="https://gitweb.gentoo.org/proj/${PN}.git/snapshot/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x64-solaris"

src_prepare(){
	# FIXME: don't install man files to a wrong location
	sed -i '/data_files/d' setup.py || die
	eapply_user
}

python_prepare_all() {
	hprefixify src/py/buildparser src/py/findclass setup.py
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install \
		--install-scripts="${EPREFIX}"/usr/libexec/${PN}
}
