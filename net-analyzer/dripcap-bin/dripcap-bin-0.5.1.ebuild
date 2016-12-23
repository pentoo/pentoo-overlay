# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit unpacker

DRIPCAP_HOME="usr/share/dripcap"

DESCRIPTION="Caffeinated Modern Packet Analyzer"
HOMEPAGE="https://dripcap.org"
SRC_URI="https://github.com/dripcap/dripcap/releases/download/v${PV}/dripcap-linux-amd64.deb  -> ${P}.deb"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
#libcap2-bin
#node-gyp mocha

RDEPEND="${DEPEND}
	>=sys-devel/gcc-5.4.0"
#libnode.so:	dev-util/electron"

S=${WORKDIR}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	mkdir -p "${D}/${DRIPCAP_HOME}"
	mv ${DRIPCAP_HOME}/* "${D}/${DRIPCAP_HOME}" || die
	dosym /${DRIPCAP_HOME}/dripcap /usr/bin/dripcap
}
