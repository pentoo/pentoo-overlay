# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/nabla-c0d3/sslyze"
SRC_URI="https://github.com/nabla-c0d3/sslyze/archive/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-python/nassl-${PV}*"

S="${WORKDIR}"/"${PN}-release-${PV}"

src_install() {
	dodir /usr/$(get_libdir)/"${PN}"/
	cp -R "${S}"/* "${D}/usr/$(get_libdir)/${PN}/"
	dosym /usr/$(get_libdir)/"${PN}"/sslyze.py /usr/bin/${PN}
}
