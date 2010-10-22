# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit eutils flag-o-matic

DESCRIPTION="The OVAL Interpreter is a freely available reference implementation created to show how information can be collected from a computer for testing, to evaluate and carry out the OVAL Definitions for that platform, and to report the resultsof the tests. "
HOMEPAGE="http://oval.mitre.org/language/download/interpreter/index.html"
SRC_URI="http://voxel.dl.sourceforge.net/sourceforge/ovaldi/${P}-src.tar.bz2"

LICENSE="OVAL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-java/xerces
		dev-java/xalan
		dev-libs/xalan-c
		dev-libs/libpcre"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile () {
	cd ${S}/project/linux
	emake -j1 || "die emake failed"
}

src_install () {
	cd ${S}/project/linux/Release || die "cd failed"
	dobin ovaldi
	into /
	dodir /usr/share/ovaldi
	addpredict /usr/share/ovaldi
	insinto /usr/share/ovaldi
	doins -r "${S}/xml"
	cd ${S}/docs
	dodoc {README.txt,terms.txt,version.txt,ovaldi.1} || die "docs failed"
}

pkg_postinst() {
	einfo
	einfo "The OVAL Interpreter collects system configuration data only available to a user with Administrator/root access"
	einfo
	ewarn
	ewarn "SINCE THIS IS SENSITIVE INFORMATION, IT IS STRONGLY RECOMMENDED THAT THE 
		   OVAL INTERPRETER DIRECTORY BE RESTRICTED TO ADMINISTRATOR ACCESS ONLY"
	ewarn
	einfo
	einfo "OVAL Definitions are created and modified on a regular basis, 
	therefore it is advised that you check the Data Files page on the OVAL Web Site 
	before running the Interpreter to ensure that you are using the most up-to-date Definitions"
	einfo
	einfo "Data files page:"
	einfo
	einfo "http://oval.mitre.org/repository/download/index.html"
	ewarn
	ewarn
	ewarn "The OVAL Interpreter is set up to validate that the Data file has not
been tampered with by checking the MD5 hash (or checksum) generated from the
data file on your computer with an MD5 hash provided by MITRE on the OVAL
Web site"
	ewarn "	You must supply the MD5 hash for the data file or use
		the -m command to skip the MD5 check"
	einfo
	einfo ".xsd and .xsl files are located in /usr/share/ovaldi/xml "
	einfo 
}
