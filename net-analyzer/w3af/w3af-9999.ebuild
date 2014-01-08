# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/w3af/w3af-1.0_rc3-r2.ebuild,v 1.1 2010/10/27 20:54:28 hwoarang Exp $

EAPI=5

PYTHON_USE_WITH="sqlite"
PYTHON_DEPEND="2"

inherit multilib python versionator git-r3

MY_P=${PN}-"$(replace_version_separator 2 '-')"
DESCRIPTION="Web Application Attack and Audit Framework"
HOMEPAGE="http://w3af.sourceforge.net/"
EGIT_REPO_URI="https://github.com/andresriancho/w3af.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc gtk"

RDEPEND=">=dev-python/fpconst-0.7.2
	dev-python/nltk
	dev-python/pyopenssl
	dev-python/pysvn
	dev-python/python-cluster
	dev-python/pyyaml
	dev-python/simplejson
	dev-python/soappy
	>=net-analyzer/scapy-2
	dev-python/lxml
	dev-python/pybloomfiltermmap
	gtk? ( dev-python/pygraphviz
		>dev-python/pygtk-2.0
		dev-python/pygtksourceview )"
DEPEND=""

#w3af bundles sqlmap, how marvelous

QA_PREBUILT="usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/mysql/linux/32/lib_mysqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/mysql/linux/64/lib_mysqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/postgresql/linux/32/8.2/lib_postgresqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/postgresql/linux/32/8.3/lib_postgresqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/postgresql/linux/32/8.4/lib_postgresqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/postgresql/linux/32/9.0/lib_postgresqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/postgresql/linux/64/8.2/lib_postgresqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/postgresql/linux/64/8.3/lib_postgresqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/postgresql/linux/64/8.4/lib_postgresqludf_sys.so
		usr/$(get_libdir)/${PN}/plugins/attack/db/sqlmap/udf/postgresql/linux/64/9.0/lib_postgresqludf_sys.so"

src_prepare(){
	rm doc/{GPL,INSTALL} || die
}

src_install() {
	insinto /usr/$(get_libdir)/w3af
	doins -r core locales plugins profiles scripts tools w3af_console || die
	use gtk && doins w3af_gui || die
	fperms +x /usr/$(get_libdir)/w3af/w3af_{gui,console} || die
	dobin "${FILESDIR}"/w3af_console || die
	if use gtk ; then
		dobin "${FILESDIR}"/w3af_gui || die
	fi
	#use flag doc is here because doc is bigger than 3 Mb
	if use doc ; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/* || die
	fi
}
