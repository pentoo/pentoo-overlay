# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Attack and Discovery Pattern Database for Application Fuzz Testing"
HOMEPAGE="https://github.com/fuzzdb-project"
EGIT_REPO_URI="https://github.com/fuzzdb-project/fuzzdb.git"
EGIT_COMMIT="ecb0850538bc9152949fa4579654d6b64e2fdb97"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir "/usr/share/${PN}/"
	cp -R "${S}"/* "${D}"/usr/share/"${PN}"/ || die "Install failed!"
}
