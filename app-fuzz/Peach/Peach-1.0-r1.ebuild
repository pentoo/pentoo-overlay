# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 python-utils-r1

DESCRIPTION="A generic fuzzer framework"
HOMEPAGE="http://peachfuzz.sourceforge.net"
SRC_URI="mirror://sourceforge/peachfuzz/Peach-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND=""

src_install() {
	rm samples/*.exe samples/PeachComTest.zip

	python_moduleinto Peach
	python_domodule Peach/.

	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins -r docs/*
	fi

#	if use examples; then
#		insinto /opt/${PN}/samples
#		doins samples/*
#		insinto /opt/${PN}
#		doins *.py
#	fi
	dodoc README.txt LICENSE.txt
}
