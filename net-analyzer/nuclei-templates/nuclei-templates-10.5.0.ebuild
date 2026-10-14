# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


DESCRIPTION="Community curated list of templates for the nuclei engine."
HOMEPAGE="https://github.com/projectdiscovery/nuclei-templates https://projectdiscovery.io"
SRC_URI="https://github.com/projectdiscovery/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /usr/share/${PN}
	rsync -a -v "${WORKDIR}/${P}/"* "${D}/usr/share/nuclei-templates/" --exclude *.md || die
}

