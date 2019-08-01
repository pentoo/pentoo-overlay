# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user systemd

DESCRIPTION="SonarQube Community Edition is an open platform to manage code quality."
HOMEPAGE="https://www.sonarqube.org/"
LICENSE="LGPL-3"
MY_PV="${PV/_alpha/M}"
MY_PV="${MY_PV/_rc/-RC}"
MY_P="sonarqube-${MY_PV}"
SRC_URI="https://binaries.sonarsource.com/Distribution/sonarqube/${MY_P}.zip"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

S="${WORKDIR}/${MY_P}"

DEPEND="app-arch/unzip"
RDEPEND=">=virtual/jdk-1.8"

INSTALL_DIR="/opt/sonar"

pkg_setup() {
	#enewgroup <name> [gid]
	enewgroup sonar
	#enewuser <user> [uid] [shell] [homedir] [groups] [params]
	enewuser sonar -1 /bin/bash /opt/sonar "sonar"
}

src_unpack() {
	unpack ${A}

	# TODO remove unneeded files
}

src_install() {
	insinto ${INSTALL_DIR}
	doins -r bin conf data elasticsearch extensions lib logs temp web COPYING
	insinto ${INSTALL_DIR}/bin
	doins "${FILESDIR}"/linux-multiarch.sh

	newconfd "${FILESDIR}/sonar.conf" sonar
	newinitd "${FILESDIR}/sonar.init" sonar

	if use systemd; then
		systemd_dounit "${FILESDIR}"/sonar.service
	fi

	fowners -R sonar:sonar ${INSTALL_DIR}

#	fperms 755 "${INSTALL_DIR}/bin/linux-x86-32/sonar.sh"
#	fperms 755 "${INSTALL_DIR}/bin/linux-x86-32/wrapper"

	fperms 755 "${INSTALL_DIR}/bin/linux-x86-64/sonar.sh"
	fperms 755 "${INSTALL_DIR}/bin/linux-x86-64/wrapper"

	fperms 755 "${INSTALL_DIR}/bin/linux-multiarch.sh"

	fperms -R 755 "${INSTALL_DIR}/elasticsearch"

	# Protect Sonar conf on upgrade
	echo "CONFIG_PROTECT=\"${INSTALL_DIR}/conf\"" > "${T}/25sonar" || die
	doenvd "${T}/25sonar"
}

pkg_postinst() {
	einfo "Please complete the upgrade using the following guideline:"
	einfo "https://docs.sonarqube.org/display/SONAR/Upgrading"
}
