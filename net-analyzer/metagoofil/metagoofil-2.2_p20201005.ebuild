# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit python-single-r1

MY_COMMIT="fc989b1b9e8869f9182922dcafd58a1f30cb8973"

DESCRIPTION="Information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="http://www.edge-security.com/metagoofil.php"
SRC_URI="https://github.com/opsdisk/metagoofil/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="media-libs/libextractor
	$(python_gen_cond_dep '
	dev-python/requests[${PYTHON_MULTI_USEDEP}]
	dev-python/googlesearch[${PYTHON_MULTI_USEDEP}]
	')
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S=${WORKDIR}/${PN}-${MY_COMMIT}

src_configure() {
	# Add the following line, so metagoofil.py can be executed directly.
	sed -i '1i#!\/usr\/bin\/python' "${PN}".py || die

	# change libextractor default location
#	sed -i -e "s:/opt/local/bin/extract:/usr/bin/extract:g"	"${PN}".py || die

	#relax deps
	sed -i "s|==|>=|g" requirements.txt
}

src_install() {
	dobin "${FILESDIR}/${PN}"

	dodir /usr/share/"${PN}"
	cp -r . "${ED}"/usr/share/${PN}/

	dodoc README.md LICENSE
}
