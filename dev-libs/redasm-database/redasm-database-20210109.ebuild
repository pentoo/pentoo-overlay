# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

HASH_COMMIT="f85b189a9b7415b7a4b5a20a0f7f9e49ee7bad25"

DESCRIPTION="Database files (signatures) for REDasm"
HOMEPAGE="http://redasm.io"
SRC_URI="https://github.com/REDasmOrg/REDasm-Database/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 ~arm64 x86"

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
