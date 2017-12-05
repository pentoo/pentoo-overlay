# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Actively probes the Internet in order to analyze topology and performance"
HOMEPAGE="http://www.caida.org/tools/measurement/scamper/"
SRC_URI="http://www.caida.org/tools/measurement/scamper/code/scamper-cvs-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="privsep debug"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/scamper-cvs-${PV}"

src_configure() {
	econf \
		$(use_enable privsep privsep) \
		$(use_enable debug debug-file)
}
