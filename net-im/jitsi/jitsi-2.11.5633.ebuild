# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#upstream smoked something here
MY_PV=$(ver_cut 3)

inherit java-pkg-2 java-ant-2
#FIXME: rename to jitsi-desktop?

DESCRIPTION="Secure IM communicator that supports SIP, XMPP, AIM/ICQ, Windows Live, Yahoo"
HOMEPAGE="https://desktop.jitsi.org/"
SRC_URI="https://github.com/jitsi/jitsi/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/gtk+:*
	x11-libs/libXScrnSaver"
DEPEND="virtual/jdk:1.8
		${CDEPEND}"
RDEPEND="${DEPEND}
	${CDEPEND}
	!net-im/jitsi-bin
	virtual/jre"

QA_PREBUILT="usr/share/jitsi/lib/native/linux.*"
QA_TEXTRELS="usr/share/jitsi/lib/native/linux.*"

EANT_BUILD_TARGET="rebuild"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	cp lib/accounts.properties.template lib/accounts.properties
	eapply_user
}

src_install() {
	#cleanup
	rm -r lib/{installer-exclude,native/freebsd*,native/mac,native/windows*,os-specific/mac}

	#resources/install/generic/installer-generic.xml
	insinto "/usr/share/${PN}"
	doins -r {lib,sc-bundles}
	doins ./resources/install/generic/run.sh
	fperms +x /usr/share/${PN}/run.sh

	newbin - ${PN} <<-EOF
	#!/bin/sh
	cd /usr/share/jitsi
	export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
	./run.sh >/dev/null 2>&1 &
	EOF
}
