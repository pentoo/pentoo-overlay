# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26 ruby27"
#inherit ruby-ng
inherit ruby-single

DESCRIPTION="Next generation web scanner, identifies what software websites are running"
HOMEPAGE="http://www.morningstarsecurity.com/research/whatweb"
SRC_URI="https://github.com/urbanadventurer/WhatWeb/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="json"

DEPEND=""
RDEPEND="${DEPEND}
	${RUBY_DEPS}
	dev-ruby/addressable
	dev-ruby/ipaddr
	json? ( dev-ruby/json )"

#future rdepend:
#dns: em-resolv-replace
#mongodb: bison bson_ext mongo rchardet

S="${WORKDIR}/WhatWeb-${PV}"

src_prepare() {
	# fix installation
#	sed -i 's|plugins-disabled||g' Makefile || die
	sed -i 's|$(DOCPATH)/$(NAME)|$(DOCPATH)/${PF}|g' Makefile || die
	sed -i '/bundle install/d' Makefile || die
	sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	sed -i -e "/^group :development do/,/^end$/d" Gemfile || die

#	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
#	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	BUNDLE_GEMFILE=Gemfile ruby -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ruby -S bundle check || die

	eapply_user
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/share/doc/"${PF}"
	DESTDIR="${D}" emake install

	#https://github.com/urbanadventurer/WhatWeb/issues/283
	mv "${D}/usr/bin/${PN}" "${D}/usr/share/whatweb/"
	cat > "${D}/usr/bin/${PN}" <<-_EOF_ || die
		#!/bin/sh
		cd /usr/share/whatweb
		./whatweb \$@
	_EOF_
	fperms 0755 "/usr/bin/${PN}"

	dodoc CHANGELOG README.md whatweb.xsl
}
