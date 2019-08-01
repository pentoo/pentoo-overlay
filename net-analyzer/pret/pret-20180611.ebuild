# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="4f3820a83cd0e8bd88fcc1d09641e54720e5bbc9"
	SRC_URI="https://github.com/RUB-NDS/PRET/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Printer Exploitation Toolkit"
HOMEPAGE="https://github.com/RUB-NDS/PRET"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-text/ghostscript-gpl
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pysnmp[${PYTHON_USEDEP}]
	media-gfx/imagemagick
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/PRET-${EGIT_COMMIT}"

src_prepare() {
	cat > ${PN} << EOF
#!/bin/sh
cd /usr/share/pret
exec ./pret.py "\${@}"
EOF
	eapply_user
}

src_install() {
	dobin ${PN}
	python_fix_shebang "${PN}.py"
	insinto "/usr/share/${PN}"
	doins -r db fonts lpd mibs overlays testpages *.py
	fperms 0755 "/usr/share/${PN}/${PN}.py"
}
