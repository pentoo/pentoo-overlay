# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils qt4 autotools

DESCRIPTION="A firewall GUI"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="nls"

DEPEND="~net-libs/libfwbuilder-${PV}
	nls? ( >=sys-devel/gettext-0.11.4 )
	~dev-java/antlr-2.7.7[cxx]
	>=dev-libs/libxslt-1.0.7"

src_configure() {
	# we'll use our eqmake instead of bundled script to process qmake files
	sed -i -e 's:^.* ./runqmake.sh$:echo:' configure \
		|| die "sed configure failed"
	# prevent install script from automatically stripping binaries - let portage do that
	sed -i -e 's/ -m 0755 -s/ -m 0755/' $(find . -name '*.pro') \
		|| die  "sed for strip failed"
	# documentation will be installed manually using dodoc & doman
	rm -f doc/doc.pro
	sed -i -e '/^SUBDIRS = src doc/s/ doc//' fwbuilder3.pro \
		|| die "sed fwbuilder3.pro failed"

	econf $(use_enable nls) || die "configure failed"

	# use eqmake to generate Makefiles
	eqmake4 fwbuilder3.pro
	for subdir in src src/res src/fwbedit src/gui src/ipt \
			src/pflib src/pf src/ipf src/ipfw src/tools \
			src/cisco_lib src/iosacl src/pix src/parsers; do
			# avoid prestrip binaries in generated Makefiles - let portage do that
			echo -e "\nQMAKE_STRIP =" >> "${subdir}/${subdir##*/}.pro"
		eqmake4 "${subdir}/${subdir##*/}.pro" -o ${subdir}/Makefile
	done
}

src_install() {
	emake DESTDIR="${D}" INSTALL_ROOT="${D}" install || die "Install failed"

	cd doc
	dodoc AUTHORS ChangeLog Credits README* \
		FWBuilder-Routing-LICENSE.txt PatchAcceptancePolicy.txt
	# release notes for 3.0.1 not found in doc dir :/
	#newdoc ReleaseNotes_${PV}.txt ReleaseNotes
	doman fwb*.1
}

pkg_postinst() {
	echo
	elog "You need to emerge sys-apps/iproute2 on the machine"
	elog "that will run the firewall script."
	echo
}
