# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="A security toolkit for organizations with attack surface discovery"
HOMEPAGE="https://github.com/ismailtasdelen/hackertarget"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ismailtasdelen/hackertarget"
else
	SRC_URI="https://github.com/ismailtasdelen/hackertarget/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]"

src_prepare() {
	mv source $PN || die
	sed -i -e "s/\['source'\]/\['${PN}'\]/" setup.py || die
	sed -i -e "s/from source/from ${PN}/g" ${PN}.py || die

	default
}

src_install() {
	distutils-r1_src_install
	python_foreach_impl python_newscript ${PN}.py $PN
}
