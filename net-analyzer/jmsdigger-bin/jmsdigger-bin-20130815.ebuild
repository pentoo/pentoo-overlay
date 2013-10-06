# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MY_P=${P}-single

DESCRIPTION="JMSDigger is an Enterprise Messaging Application assessment tool focuses on ActiveMQ"
HOMEPAGE="https://github.com/OpenSecurityResearch/jmsdigger"
SRC_URI="http://dev.pentoo.ch/~blshkv/distfiles/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~arm ~amd64"
IUSE=""

RDEPEND="virtual/jre"
DEPEND="virtual/jdk"

DEPEND=""
RDEPEND="virtual/jre"

S=${WORKDIR}

src_install() {
	dodir /opt/${PN}
	insinto /opt/${PN}
	doins ${MY_P}.jar
	echo -e "#!/bin/sh\njava -jar /opt/${PN}/${MY_P}.jar >/dev/null 2>&1 &\n" > "${PN}"
	dobin ${PN}
}
