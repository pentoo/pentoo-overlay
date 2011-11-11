# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/Peach/Peach-0.4.ebuild,v 1.1.1.2 2006/03/13 21:42:50 grimmlin Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="A generic fuzzer framework"
HOMEPAGE="http://peachfuzz.sourceforge.net"
SRC_URI="mirror://sourceforge/peachfuzz/Peach-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

RDEPEND=""

PYTHON_MODNAME="Peach"

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	python_get_version
	rm samples/*.exe samples/PeachComTest.zip
	mkdir -p "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/${PYTHON_MODNAME}/
	cp -a ${PN}/* "${D}"/usr/$(get_libdir)/python${PYVER}/site-packages/${PYTHON_MODNAME}/

	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins -r docs/*
	fi
	if use examples; then
		insinto /opt/${PN}/samples
		doins samples/*
		insinto /opt/${PN}
		doins *.py
	fi
	dodoc README.txt LICENSE.txt
}
