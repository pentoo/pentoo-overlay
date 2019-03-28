# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="dependency-check"

DESCRIPTION="A utility that detects vulnerabilities in application dependencies"
HOMEPAGE="https://www.owasp.org/index.php/OWASP_Dependency_Check"
SRC_URI="http://dl.bintray.com/jeremy-long/owasp/dependency-check-${PV}-release.zip -> ${P}.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.7
		dev-java/ant-core
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.7"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	sed -i -e 's|^PRGDIR=.*|PRGDIR="/etc/dependency-check"|' bin/${MY_PN}.sh || die "Sed failed!"
	sed -i -e 's|^BASEDIR=`cd "$PRGDIR/.."|BASEDIR=`cd "$PRGDIR"|' bin/${MY_PN}.sh || die "Sed failed!"
	eapply_user
}

src_install() {
	dodir /etc/${MY_PN}
	insinto /etc/${MY_PN}
	doins -r repo plugins
	newsbin bin/${MY_PN}.sh ${MY_PN}
}
