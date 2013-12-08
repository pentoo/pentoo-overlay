# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 git-2

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/iSECPartners/sslyze"
EGIT_REPO_URI="https://github.com/iSECPartners/sslyze.git"
EGIT_COMMIT="9ff352dcd440ba86749e6931d151569a22e1d22e"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/nassl"

src_install() {
	dodir /usr/$(get_libdir)/"${PN}"/
	cp -R "${S}"/* "${D}/usr/$(get_libdir)/${PN}/"
	dosym /usr/$(get_libdir)/"${PN}"/sslyze.py /usr/bin/${PN}
}
