# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22"

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
