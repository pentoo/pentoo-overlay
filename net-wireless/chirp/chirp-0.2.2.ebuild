# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2:2.6:2.7"

inherit python distutils


DESCRIPTION=""
HOMEPAGE="http://chirp.danplanet.com"

if [[ ${PV} == "9999" ]] ; then
	inherit mercurial
	EHG_REPO_URI="http://d-rats.com/hg/chirp.hg"
	KEYWORDS="-*"
else
	SRC_URI="http://chirp.danplanet.com/download/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pyserial
	dev-libs/libxml2[python]"

RESTRICT_PYTHON_ABIS="2.[67]"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
