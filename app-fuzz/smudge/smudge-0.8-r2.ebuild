# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 python-utils-r1

DESCRIPTION="Smudge is basically a port of SPIKE into python scripts"
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI="http://dev.pentoo.ch/~grimmlin/distfiles/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_install() {
	python_moduleinto smudge
	python_domodule *.py

	insinto /opt/smudge/
	dodir /opt/smudge/logs/
	insopts -m0755
	doins *.py
	insopts -m0644
	insinto /opt/smudge/misc
	doins -r misc/*

	dosbin "${FILESDIR}"/${PN}
	dodoc COPYING.txt CHANGELOG.txt README.txt

	}
