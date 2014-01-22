# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

inherit eutils multilib

DESCRIPTION="A lightweight multi-platform, multi-architecture disassembly framework"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/capstone/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

#TODO: add java and python bindings

src_install() {
	emake DESTDIR="${D}" install
	dodir /usr/share/"${PN}"/
	cp -R "${S}/tests" "${D}/usr/share/${PN}/" || die "Install failed!"
	dodoc README
}
