# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Decode, monitor, record and stream trunked mobile and related radio protocols"
HOMEPAGE="https://github.com/DSheirer/sdrtrunk"
SRC_URI="https://github.com/DSheirer/sdrtrunk/releases/download/v0.4.0/sdr-trunk-linux-x86_64-v0.4.0.zip"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="virtual/jre:*
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	!net-wireless/sdrtrunk"

S="${WORKDIR}/sdr-trunk-linux-x86_64-v0.4.0"

QA_PREBUILT="opt/sdrtrunk/bin/* opt/sdrtrunk/lib/*/* opt/sdrtrunk/lib/*"

QA_PRESTRIPPED="opt/sdrtrunk/lib/minimal/libjvm.so"

src_install() {
	dodir /opt/sdrtrunk/
	cp -R * "${ED}"/opt/sdrtrunk/

	dosym "${EPREFIX}"/opt/sdrtrunk/bin/sdr-trunk /usr/bin/sdr-trunk
}
