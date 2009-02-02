# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils qt4

DESCRIPTION="Firewall Builder 2.1 API library and compiler framework"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="snmp ssl stlport"

DEPEND=">=dev-libs/libxml2-2.4.10
	>=dev-libs/libxslt-1.0.7
	snmp? ( net-analyzer/net-snmp )
	ssl? ( dev-libs/openssl )
	stlport? ( dev-libs/STLport )
	|| ( ( x11-libs/qt-core:4
		x11-libs/qt-gui:4 )
		x11-libs/qt:4 )"

src_configure() {
	# we'll use our eqmake instead of bundled script to process qmake files
	sed -i -e 's:^.* ./runqmake.sh$:echo:' configure \
		|| die "sed configure failed"

	econf   $(use_with ssl openssl) \
		$(use_with snmp ucdsnmp) \
		$(use_with stlport stlport) \
		|| die "configure failed"

	# use eqmake to generate Makefiles
	eqmake4 ${PN}.pro
	for subdir in src src/fwbuilder src/fwcompiler src/test src/confscript \
			etc doc migration; do
		# avoid prestrip binaries in generated Makefiles - let portage do that
		echo -e "\nQMAKE_STRIP =" >> "${subdir}/${subdir##*/}.pro"
		eqmake4 "${subdir}/${subdir##*/}.pro" -o ${subdir}/Makefile
	done
}

src_install() {
	emake DESTDIR="${D}" INSTALL_ROOT="${D}" install || die "Install failed"

	cd "${D}"/usr/share/doc/${PF}
	rm COPYING INSTALL
	prepalldocs
}
