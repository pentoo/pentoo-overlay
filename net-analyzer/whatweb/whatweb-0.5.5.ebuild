# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"
inherit ruby-single

DESCRIPTION="Next generation web scanner, identifies what software websites are running"
HOMEPAGE="http://www.morningstarsecurity.com/research/whatweb"
SRC_URI="https://github.com/urbanadventurer/WhatWeb/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="json"

DEPEND="dev-ruby/bundler:2"
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
	sed -i '/gzip/d' Makefile || die
#	sed -i 's|plugins-disabled||g' Makefile || die
	sed -i 's|$(DOCPATH)/$(NAME)|$(DOCPATH)/${PF}|g' Makefile || die
	sed -i '/bundle install/d' Makefile || die
	sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	sed -i -e "/^group :development do/,/^end$/d" Gemfile || die

	if [ -f Gemfile ]; then
		BUNDLE_GEMFILE=Gemfile ruby -S bundle install --local || die
		BUNDLE_GEMFILE=Gemfile ruby -S bundle check || die
	fi

	eapply_user
}

src_compile() {
	einfo "Nothing to compile"
}

all_ruby_install() {
	dodir /usr/share/doc/"${PF}"
	dodir /usr/bin
	DESTDIR="${D}" emake install

	dodoc CHANGELOG.md README.md whatweb.xsl
}
