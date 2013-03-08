# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit rpm

DESCRIPTION="Secure IM communicator that supports SIP, XMPP/Jabber, AIM/ICQ, Windows Live, Yahoo"
HOMEPAGE="https://jitsi.org/"
SRC_URI="
	x86? ( https://download.jitsi.org/jitsi/rpm/jitsi-${PV}-4506.10553.i386.rpm )
	amd64? ( https://download.jitsi.org/jitsi/rpm/jitsi-${PV}-4506.10553.x86_64.rpm )"

RESTRICT="strip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( virtual/jre virtual/jdk )"
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
