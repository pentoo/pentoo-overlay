# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm
MY_PV=$(ver_rs 2 -)

DESCRIPTION="Secure IM communicator that supports SIP, XMPP, AIM/ICQ, Windows Live, Yahoo"
HOMEPAGE="https://jitsi.org/"
SRC_URI="
	x86? ( https://download.jitsi.org/jitsi/rpm/jitsi-${MY_PV}.i686.rpm )
	amd64? ( https://download.jitsi.org/jitsi/rpm/jitsi-${MY_PV}.x86_64.rpm )"

RESTRICT="strip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.7"

QA_PREBUILT="
	usr/share/jitsi/lib/native/*
"

S="${WORKDIR}"

src_unpack() {
	rpm_unpack
}

src_install() {
	cp -pPR "${S}/usr" "${D}"/
}
