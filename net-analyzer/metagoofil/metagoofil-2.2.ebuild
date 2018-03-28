# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

MY_COMMIT="823b1146eb13a6e5c4f72b33461af5289b191abb"

DESCRIPTION="Information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="http://www.edge-security.com/metagoofil.php"
SRC_URI="https://github.com/laramies/metagoofil/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-libs/libextractor"

S=${WORKDIR}/${PN}-${MY_COMMIT}

src_configure() {
	# Add the following line, so metagoofil.py can be executed directly.
	sed -i '1i#!\/usr\/bin\/python' "${PN}".py || die

	# change libextractor default location
#	sed -i -e "s:/opt/local/bin/extract:/usr/bin/extract:g"	"${PN}".py || die
}

src_install() {
	dobin "${FILESDIR}/${PN}"

	dodir /usr/share/"${PN}"
	cp -r . "${ED}"/usr/share/${PN}/

	dodoc README LICENSES
}
