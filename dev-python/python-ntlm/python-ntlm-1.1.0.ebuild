# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Clamd is a python interface to Clamd (Clamav daemon)"
HOMEPAGE="https://github.com/mullender/python-ntlm"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="example"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	python_foreach_impl distutils-r1_python_install || die
	if ! use example ; then
		rm -r "${D}"/usr/bin/ || die
		rm -r "${D}"/usr/lib/python-exec || die
	fi
}
