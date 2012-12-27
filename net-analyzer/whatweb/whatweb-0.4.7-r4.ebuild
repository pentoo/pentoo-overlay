# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Next generation web scanner, identifies what software websites are running"
HOMEPAGE="http://www.morningstarsecurity.com/research/whatweb"
#Actual SRC_URI has broken WAF on it that prevents wget from downloading so we mirror
# Pentoo issue 62
#SRC_URI="http://www.morningstarsecurity.com/downloads/${P}.tar.gz"
SRC_URI="http://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="json"

DEPEND="dev-lang/ruby"
RDEPEND="${DEPEND}
	json? ( dev-ruby/json )"

#future rdepend:
#dns: em-resolv-replace
#mongodb: bison bson_ext mongo rchardet

src_prepare() {
	# fix install
	sed -i 's|plugins-disabled||g' Makefile || die
	sed -i 's|$(DOCPATH)/$(NAME)|$(DOCPATH)/${PF}|g' Makefile || die
	sed -i -e 's:#!/usr/bin/env ruby:#!/usr/bin/env ruby18:' whatweb || die
}

src_compile() {
	# do nothing
	true
}

src_install() {
	dodir /usr/share/doc/"${PF}"
	DESTDIR="${D}" emake install || die "install failed"
	dodoc CHANGELOG README TODO whatweb.xsl || die
}
