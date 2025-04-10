# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The Swiss-Army Knife for SOAP Testing"
HOMEPAGE="https://www.soapui.org/ https://github.com/SmartBear/soapui"
SRC_URI="https://dl.eviware.com/soapuios/${PV}/SoapUI-${PV}-linux-bin.tar.gz"
S="${WORKDIR}/SoapUI-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"

RESTRICT="strip mirror"

RDEPEND=">=virtual/jre-1.6"

INSTALLDIR="/opt/SoapUI"

src_install() {
	# application
	insinto ${INSTALLDIR}
	doins -r Tutorials bin lib HelloWS-soapui-project.xml soapui-settings.xml

	# binaries
	chmod 755 "${D}/${INSTALLDIR}/bin/loadtestrunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/mockservicerunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/securitytestrunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/soapui.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/testrunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/toolrunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/wargenerator.sh"

	dosym -r "${INSTALLDIR}/bin/soapui.sh" /usr/bin/soapui

	# default docs
	dodoc README.md
	dodoc RELEASENOTES.txt
}
