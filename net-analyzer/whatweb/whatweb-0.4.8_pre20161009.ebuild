# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23"
inherit ruby-ng git-r3

DESCRIPTION="Next generation web scanner, identifies what software websites are running"
HOMEPAGE="http://www.morningstarsecurity.com/research/whatweb"
EGIT_REPO_URI="https://github.com/urbanadventurer/WhatWeb.git"
EGIT_COMMIT="039768f41a6cd45ec70c89b81616b669bc92ac0f"

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

S="${WORKDIR}/${P}"

ruby-ng_src_prepare() {
	# fix installation
	sed -i 's|plugins-disabled||g' Makefile || die
	sed -i 's|$(DOCPATH)/$(NAME)|$(DOCPATH)/${PF}|g' Makefile || die
	eapply_user
}

ruby-ng_src_install() {
	dodir /usr/share/doc/"${PF}"
	DESTDIR="${D}" emake install
	dodoc CHANGELOG README whatweb.xsl
}
