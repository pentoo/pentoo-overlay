# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="The fastest JSON parser and object serializer"
HOMEPAGE="http://rubygems.org/gems/oj"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_bdepend "
	test? ( dev-ruby/minitest:5
	dev-ruby/rails:4
	=dev-ruby/rake-compiler-0.9* )"

each_ruby_configure() {
	${RUBY} -C ext/oj extconf.rb || die "extconf failed"
}

each_ruby_compile() {
	emake V=1 -C ext/oj
	cp ext/oj/oj$(get_modname) lib/oj || die "cp failed"
}
