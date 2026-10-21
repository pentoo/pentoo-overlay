# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Modern Java decompiler aiming to be as accurate as possible"
HOMEPAGE="https://vineflower.org https://github.com/Vineflower/vineflower"
SRC_URI="https://github.com/Vineflower/vineflower/releases/download/${PV}/vineflower-${PV}.jar -> ${P}.jar"

S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="|| ( virtual/jre virtual/jdk )"

src_unpack() {
	dodir "${S}"
	cp -L "${DISTDIR}/${P}.jar" "${S}/vineflower.jar" || die
}

src_install() {
	insinto "/opt/${PN}/"
	doins vineflower.jar
	dobin "${FILESDIR}/vineflower"
}
