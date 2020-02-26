# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"

inherit ruby-fakegem

DESCRIPTION="Calculate the similarity between two strings"
HOMEPAGE="https://github.com/valcker/similar_text-ruby"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

each_ruby_configure() {
	${RUBY} -Cext/${PN} extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/${PN} V=1
	cp ext/${PN}/${PN}.so lib/
}
