# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
inherit python-single-r1

HASH_COMMIT="fc989b1b9e8869f9182922dcafd58a1f30cb8973"

DESCRIPTION="Information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="http://www.edge-security.com/metagoofil.php"
SRC_URI="https://github.com/opsdisk/metagoofil/archive/${HASH_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="$(python_gen_cond_dep '
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/googlesearch[${PYTHON_USEDEP}]
	')
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S=${WORKDIR}/${PN}-${HASH_COMMIT}

src_configure() {
	# Add the following line, so metagoofil.py can be executed directly.
	sed -i '1i#!\/usr\/bin\/python' "${PN}".py || die

	#relax deps
	sed -i "s|==|>=|g" requirements.txt
}

src_install() {
	dobin "${FILESDIR}/${PN}"

	# remove things we don't need on disk
	rm Dockerfile || die
	rm requirements.txt || die
	rm LICENSE || die
	rm .gitignore || die
	dodir /usr/share/"${PN}"
	cp -r . "${ED}"/usr/share/${PN}/

	dodoc README.md
}
