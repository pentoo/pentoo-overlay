# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A malware identification and classification tool"
HOMEPAGE="http://virustotal.github.io/yara/"
SRC_URI="https://github.com/virustotal/yara/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="python"

DEPEND="dev-libs/openssl:0="
RDEPEND="${DEPEND}"
PDEPEND="python? ( ~dev-python/yara-python-${PV} )"

src_prepare() {
	default
	eautoreconf
}
