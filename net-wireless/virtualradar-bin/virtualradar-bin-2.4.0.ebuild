# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Open-source .NET application for ads-b mapping"
HOMEPAGE="http://www.virtualradarserver.co.uk/Default.aspx"
SRC_URI="http://www.virtualradarserver.co.uk/Files/VirtualRadar.tar.gz -> "${P}".tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/mono-4.4.1.0"

S="${WORKDIR}"

# Mono 4 workaround
src_configure() {
	cp "${FILESDIR}"/VirtualRadar.exe.config "${S}"
}

src_install() {
	insinto /opt/"${PN}"
	doins -r *
	dobin "${FILESDIR}"/virtualradar
}
