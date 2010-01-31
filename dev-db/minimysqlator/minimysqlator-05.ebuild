# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlat/sqlat-1.1.0.ebuild,v 1.1.1.1 2006/02/27 20:03:41 grimmlin Exp $

MY_P="mms_${PV}.jar"
DESCRIPTION="Minimysqlator is a MySQL injection tools that facilitates the retrieval of DB and more"
HOMEPAGE="http://www.scrt.ch/pages/minimysqlator.html"
SRC_URI="http://www.scrt.ch/outils/mms/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/jre"
DEPEND=""

S="${WORKDIR}"
src_unpack() {
	echo ${A} ${DISTDIR}
	cp -L "${DISTDIR}/${MY_P}" "${S}" || die
}

src_compile() {
	einfo "Nothing to compile"
}

src_install () {
	insinto /opt/minimysqlator/
	doins "${MY_P}" || die
	dosbin "${FILESDIR}/${PN}" || die
	sed -i 's|03|05|' "${D}"/usr/sbin/${PN}
}
