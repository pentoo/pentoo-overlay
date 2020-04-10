# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-ant-2

DESCRIPTION="Secure IM communicator that supports SIP, XMPP, AIM/ICQ, Windows Live, Yahoo"
HOMEPAGE="https://jitsi.org/"
SRC_URI="https://download.jitsi.org/jitsi/nightly/src/jitsi-src-${PV}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#adding :* to virtual/jre breaks this ebuild, please don't do that
RDEPEND="virtual/jre
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/gtk+:*
	x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}
	!net-im/jitsi-bin
	virtual/jdk:1.8"

EANT_BUILD_TARGET="rebuild"

S="${WORKDIR}/${PN}"

src_prepare() {
	cp lib/accounts.properties.template lib/accounts.properties
	eapply_user
}

src_install() {
	#generic/installer-generic.xml
	insinto "/usr/share/${PN}"
	doins -r {lib,sc-bundles}
	doins ./resources/install/generic/run.sh
	fperms +x /usr/share/${PN}/run.sh

	newbin - ${PN} <<-EOF
	#!/bin/sh
	cd /usr/share/jitsi
	./run.sh >/dev/null 2>&1 &
	EOF
}
