# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="Metagoofil is an information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="http://www.edge-security.com/metagoofil.php"
SRC_URI="http://www.edge-security.com/soft/${P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-libs/libextractor"

S="${WORKDIR}/${PN}"

src_configure() {
	# Add the following line, so metagoofil.py can be executed directly.
	sed -i '1i#!\/usr\/bin\/python' "${PN}".py || die

	# change libextractor default location
	sed -i -e "s:/opt/local/bin/extract:/usr/bin/extract:g"	"${PN}".py || die
}

src_install() {
	newbin ${PN}.py ${PN}
	python_fix_shebang "${ED}"usr/bin
	dodoc README
}
