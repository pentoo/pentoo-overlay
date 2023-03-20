# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8


DESCRIPTION="Attack and Discovery Pattern Database for Application Fuzz Testing"
HOMEPAGE="https://github.com/fuzzdb-project"

LICENSE="BSD"
SLOT="0"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fuzzdb-project/fuzzdb.git"
else
	inherit vcs-snapshot
	KEYWORDS="~amd64 ~arm ~x86"
	EGIT_COMMIT="5656ab25dc6bb43bae32236fab775658a90d7380"
	SRC_URI="https://github.com/fuzzdb-project/fuzzdb/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dodir "/usr/share/${PN}/"
	cp -R "${S}"/* "${D}"/usr/share/"${PN}"/ || die "Install failed!"
}
