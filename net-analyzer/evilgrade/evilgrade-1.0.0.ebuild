# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A modular framework that takes advantage of poor upgrade implementations by injecting fake updates."
SRC_URI="http://www.infobyte.com.ar/down/isr-${P}.tar.gz"
HOMEPAGE="http://www.infobyte.com.ar/developments.html"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-perl/Data-Dump"

S=${WORKDIR}/isr-${PN}

src_install() {
	cd ${S}
	dodoc docs/*

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins evilgrade

	dodir /usr/share/${PN}/agent
	insinto /usr/share/${PN}/agent
	doins agent/*

	dodir /usr/share/${PN}/include
	insinto /usr/share/${PN}/include
	doins include/*

	dodir /usr/share/${PN}/isrcore
	insinto /usr/share/${PN}/isrcore
	doins isrcore/*

	dodir /usr/share/${PN}/modules
	insinto /usr/share/${PN}/modules
	doins modules/*
}

