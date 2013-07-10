# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.6"

inherit cmake-utils python

DESCRIPTION="A digital forensics framework which aims to analyze and recover any
kind of digital artifact."
HOMEPAGE="http://tracker.digital-forensic.org/"
SRC_URI="http://dev.pentoo.ch/~zero/distfiles/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc ewf +aff +pff"

DEPEND=">=dev-lang/swig-1.3.38
		dev-python/sip
		doc? ( >=dev-python/PyQt4-4.4.0[webkit,assistant] )
		!doc? ( >=dev-python/PyQt4-4.4.0 )
		>=sys-apps/file-4.26[python]
		"
RDEPEND="${DEPEND}
		 ewf? ( >=app-forensics/libewf-20100226 )
		 aff? ( >=app-forensics/afflib-3.6.8 )
		 pff? ( >=app-forensics/libpff-0.0.20120513_alpha )
		 "

pkg_setup() {
        python_set_active_version 2
        python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-disable-qtassistant.patch"
	epatch "${FILESDIR}/${P}-libpff-0.0.20120513.patch"

	python_convert_shebangs -r 2 .
	sed -i 's:^python:python2:' ressources/linux_launcher.sh || die "sed makefile"

}

src_configure() {
	mycmakeargs+=( "-DINSTALL:BOOLEAN=ON" )
	cmake-utils_src_configure
}
