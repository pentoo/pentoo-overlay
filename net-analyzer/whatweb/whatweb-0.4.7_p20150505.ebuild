# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"
inherit ruby-ng git-2

DESCRIPTION="Next generation web scanner, identifies what software websites are running"
HOMEPAGE="http://www.morningstarsecurity.com/research/whatweb"
#SRC_URI="http://www.morningstarsecurity.com/downloads/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/urbanadventurer/WhatWeb.git"
EGIT_COMMIT="48b9682a0fbf1607f1d3565f9aab3442aee14d12"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="json"

DEPEND=""
RDEPEND="${DEPEND}
	json? ( dev-ruby/json )"

#future rdepend:
#dns: em-resolv-replace
#mongodb: bison bson_ext mongo rchardet

ruby-ng_src_prepare() {
	# fix install
	sed -i 's|plugins-disabled||g' Makefile || die
	sed -i 's|$(DOCPATH)/$(NAME)|$(DOCPATH)/${PF}|g' Makefile || die
}

ruby-ng_src_install() {
	dodir /usr/share/doc/"${PF}"
	DESTDIR="${D}" emake install
	dodoc CHANGELOG README whatweb.xsl
}
