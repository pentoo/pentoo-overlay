# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Free OVAL definition's interpreter"
HOMEPAGE="http://oval.mitre.org/language/interpreter.html"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rpm"

DEPEND="dev-libs/libpcre
	dev-libs/xalan-c
	dev-libs/xerces-c
	dev-libs/libgcrypt
	net-nds/openldap"
RDEPEND="${DEPEND}
	rpm? ( app-arch/rpm )"

S="${WORKDIR}/${P}-src"

src_prepare() {
	epatch "${FILESDIR}"/${P}-xerces3.patch
	epatch "${FILESDIR}"/${P}-strnicmp.patch

	# rpm probes support is build dependant only on the presence of the rpm binary
	if use rpm ; then
		#Same problems as bug 274679, so i do a local copy of the header and patch it
		cp /usr/include/rpm/rpmdb.h src/probes/linux/ || die
		epatch "${FILESDIR}"/use_local_rpmdb.patch
		epatch "${FILESDIR}"/rpmdb.patch
	else
		einfo "Disable rpm probes"
		sed -i 's/^PACKAGE_RPM/#PACKAGE_RPM/g' project/linux/Makefile || die
	fi
	# same thing for dpkg, but package dpkg is not sufficient, needs app-arch/apt-pkg that is not on tree
	einfo "Disable dpkg probes"
	sed -i 's/^PACKAGE_DPKG/#PACKAGE_DPKG/g' project/linux/Makefile || die
}

src_compile () {
	emake -C project/linux || die
}

src_install () {
	# no make install in Makefile
	dosbin project/linux/Release/ovaldi project/linux/ovaldi.sh || die
	dodir /var/log/${PN} || die
	insinto /usr/share/${PN}
	doins xml/* || die
	dodoc docs/{README.txt,version.txt} || die
	doman docs/ovaldi.1 || die
}
