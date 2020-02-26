# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

HASH_COMMIT=3865f7cde7f1c718840e027b08d1d526a038b753

DESCRIPTION="Database files (signatures) for REDasm"
HOMEPAGE="http://redasm.io"
SRC_URI="https://github.com/REDasmOrg/REDasm-Database/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/REDasm-Database-${HASH_COMMIT}"

src_install() {
	insinto /usr/share/redasm/database/
	doins -r *
}
