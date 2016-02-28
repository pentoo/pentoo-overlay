# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit rpm

PV_RAND="5426"

DESCRIPTION="Secure IM communicator that supports SIP, XMPP, AIM/ICQ, Windows Live, Yahoo"
HOMEPAGE="https://jitsi.org/"
SRC_URI="
	x86? ( https://download.jitsi.org/jitsi/rpm/jitsi-${PV}-${PV_RAND}.i686.rpm )
	amd64? ( https://download.jitsi.org/jitsi/rpm/jitsi-${PV}-${PV_RAND}.x86_64.rpm )"

RESTRICT="strip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( virtual/jre:1.7 virtual/jdk:1.7 )"
DEPEND="${RDEPEND}
	app-arch/rpm2targz"

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
