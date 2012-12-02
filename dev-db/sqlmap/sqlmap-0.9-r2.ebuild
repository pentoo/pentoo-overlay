# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Python based fuzzer for multi protocols, and faultinject"
HOMEPAGE="http://sqlmap.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

QA_PRESTRIPPED="
	/usr/share/${PN}/lib/contrib/upx/linux/upx
	/usr/share/${PN}/udf/mysql/linux/32/lib_mysqludf_sys.so
	/usr/share/${PN}/udf/mysql/linux/64/lib_mysqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/32/8.3/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/32/8.4/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/32/8.2/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/64/8.3/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/64/8.4/lib_postgresqludf_sys.so
	/usr/share/${PN}/udf/postgresql/linux/64/8.2/lib_postgresqludf_sys.so"

QA_DT_HASH="${QA_PRESTRIPPED}"

QA_TEXTRELS="
	usr/share/${PN}/udf/mysql/linux/32/lib_mysqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.3/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.4/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.2/lib_postgresqludf_sys.so"

S="${WORKDIR}"/$PN

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	# fix broken tarball
	find . -name .svn |xargs rm -r
	# Don't forget to disable the revision check since we removed the SVN files
	sed -i -e 's/= getRevisionNumber()/= "Unknown revision"/' lib/core/settings.py

	dodoc doc/* || die "failed to add docs"
	rm -rf doc
	dodir /usr/share/"${PN}"/
	cp -R * "${D}"/usr/share/"${PN}"/
	dosym /usr/share/"${PN}"/sqlmap.py /usr/sbin/sqlmap
}
