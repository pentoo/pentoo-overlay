# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

inherit multilib ruby-fakegem

DESCRIPTION="Typhoeus runs HTTP requests in parallel while cleanly encapsulating handling logic"
HOMEPAGE="https://rubygems.org/gems/typhoeus"

LICENSE="BSD"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"

ruby_add_rdepend "dev-ruby/mime-types"

each_ruby_configure() {
	${RUBY} -C ext/typhoeus extconf.rb || die "extconf failed"
}

each_ruby_compile() {
	emake -C ext/typhoeus
	cp ext/typhoeus/native$(get_modname) lib/typhoeus || die "cp failed"
}
