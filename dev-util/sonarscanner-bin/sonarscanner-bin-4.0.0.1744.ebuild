# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user eutils

DESCRIPTION="SonarQube Command-Line Scanner"
HOMEPAGE="https://www.sonarqube.org/"
LICENSE="LGPL-3"
MY_PV="${PV/_alpha/M}"
MY_PV="${MY_PV/_rc/-RC}"
MY_P="sonar-scanner-cli-${MY_PV}-linux"
SRC_URI="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${MY_P}.zip"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="embedded_jre"

S="${WORKDIR}/sonar-scanner-${MY_PV}-linux"

DEPEND="app-arch/unzip"
RDEPEND="!embedded_jre? ( >=virtual/jre-1.8 )"

INSTALL_DIR="/opt/sonar-scanner"

src_unpack() {
	unpack ${A}

	# TODO remove unneeded files
}

src_prepare() {
	if ! use embedded_jre; then
	   epatch "${FILESDIR}/${PN}-system_jre.patch"
	fi

	eapply_user
}

src_install() {
	insinto ${INSTALL_DIR}

	if use embedded_jre; then
	   doins -r bin conf jre lib
	   fperms -R 755 "${INSTALL_DIR}/jre/bin"
	else
	   doins -r bin conf lib
	fi

	fperms -R 755 "${INSTALL_DIR}/bin"

	dosym ${INSTALL_DIR}/bin/sonar-scanner /usr/bin/sonar-scanner
	dosym ${INSTALL_DIR}/bin/sonar-scanner-debug /usr/bin/sonar-scanner-debug

	# Protect Sonar conf on upgrade
	echo "CONFIG_PROTECT=\"${INSTALL_DIR}/conf\"" > "${T}/25sonarcli" || die
	doenvd "${T}/25sonarcli"
}
