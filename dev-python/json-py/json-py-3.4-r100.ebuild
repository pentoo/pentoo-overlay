# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoogle/pygoogle-0.6.ebuild,v 1.4 2005/07/02 16:48:16 fserb Exp $

# http://bugs.gentoo.org/show_bug.cgi?id=112451

inherit eutils distutils

MY_PV=${PV/./_}
DESCRIPTION="JSON reader/writer for python."
SRC_URI="mirror://sourceforge/json-py/${PN}-${MY_PV}.zip"
HOMEPAGE="http://sourceforge.net/projects/json-py/"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="~x86 ~ppc-macos ~amd64"

DEPEND="virtual/python"
S=${WORKDIR}

src_compile() {
	return
}

src_install() {
	cd ${S}
#	python_version
#	insinto /usr/$(get_libdir)/python${PYVER}/site-packages
	insinto /usr/$(get_libdir)/python$(python_get_version)/site-packages
	doins json.py minjson.py
	dodoc changes.txt license.txt readme.txt
}
