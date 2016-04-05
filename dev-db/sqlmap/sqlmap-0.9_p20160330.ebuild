# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 git-2

DESCRIPTION="Automatic SQL injection and database takeover tool "
HOMEPAGE="http://sqlmap.org"
EGIT_REPO_URI="https://github.com/sqlmapproject/sqlmap.git"
EGIT_COMMIT="e83d8f6143497ef4f7230551088f9844bea81ebc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ntlm"

DEPEND=""
RDEPEND="ntlm? ( dev-python/python-ntlm )"

QA_PREBUILT="
	usr/share/${PN}/udf/mysql/linux/32/lib_mysqludf_sys.so
	usr/share/${PN}/udf/mysql/linux/64/lib_mysqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.2/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.3/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.4/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/9.0/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/9.1/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.2/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.3/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.4/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/9.0/lib_postgresqludf_sys.so"

src_install () {
	# fix broken tarball
	find ./ -name .git | xargs rm -rf
	# Don't forget to disable the revision check since we removed the SVN files
	sed -i -e 's/= getRevisionNumber()/= "Unknown revision"/' lib/core/settings.py

	dodoc -r doc/*
	rm -rf doc/
	dodir /usr/share/${PN}/

	cp -R * "${ED}"/usr/share/${PN}/
	python_fix_shebang "${ED}"/usr/share/${PN}
	dosym /usr/share/${PN}/sqlmap.py /usr/bin/${PN}
}
