# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-ant-2

DESCRIPTION="https://github.com/jitsi/jitsi-videobridge"
HOMEPAGE="https://jitsi.org/ https://github.com/jitsi/jitsi-videobridge"
SRC_URI="https://download.jitsi.org/jitsi-videobridge/src/${PN}-src-${PV}.zip"

LICENSE="Apache-2.0"
SLOT="0"
#WIP
#KEYWORDS="~amd64 ~x86"
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

#EANT_BUILD_TARGET="rebuild"

S="${WORKDIR}/${PN}-src-${PV}"

#src_prepare() {
#	cp lib/accounts.properties.template lib/accounts.properties
#	eapply_user
#}
