# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Command line Java Decompiler"
HOMEPAGE="https://github.com/kwart/jd-cli"
SRC_URI="https://repo1.maven.org/maven2/com/github/kwart/jd/jd-cli/1.2.1/jd-cli-1.2.1.jar"
#https://github.com/kwart/jd-cli/releases/download/jd-cli-${PV}/jd-cli-${PV}-dist.tar.gz"

LICENSE="Apache-2.0"
SLOT="GPL-3"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="!dev-util/jd-cli"
RDEPEND="|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${A}" "${S}/jd-cli.jar" || die
}

src_install() {
	insinto "/opt/jd-cli/"
	doins jd-cli.jar
	cp ${FILESDIR}/jd-cli "${ED}"/opt/jd-cli/
	dosym "${EPREFIX}"/opt/jd-cli/jd-cli /usr/bin/jd-cli
}
