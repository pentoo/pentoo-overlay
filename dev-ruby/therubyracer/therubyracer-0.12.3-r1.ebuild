# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"

inherit ruby-fakegem

DESCRIPTION="Call JavaScript code and manipulate JavaScript objects from Ruby"
HOMEPAGE="http://github.com/cowboyd/therubyracer"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
#unable to compile libv8 and verify the ebuild
#KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "=dev-ruby/libv8-3.16.14*
	dev-ruby/ref"

each_ruby_configure() {
	${RUBY} -C ext/v8/ extconf.rb || die "extconf failed"
}

each_ruby_compile() {
	emake V=1 -C ext/v8
	cp ext/v8/v8$(get_modname) lib/v8 || die "cp failed"
}
