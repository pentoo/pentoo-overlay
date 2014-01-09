# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/iSECPartners/sslyze"
SRC_URI="https://github.com/iSECPartners/sslyze/archive/release-0.8.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-python/nassl-0.8*"

S="${WORKDIR}"/"${PN}-release-${PV}"

src_install() {
	dodir /usr/$(get_libdir)/"${PN}"/
	cp -R "${S}"/* "${D}/usr/$(get_libdir)/${PN}/"
	dosym /usr/$(get_libdir)/"${PN}"/sslyze.py /usr/bin/${PN}
}
