# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24"
RUBY_FAKEGEM_EXTRAINSTALL="app bin spec"

inherit ruby-fakegem

DESCRIPTION="Wordpress security scanner"
HOMEPAGE="http://wpscan.org/"
SRC_URI="https://github.com/wpscanteam/wpscan/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_rdepend "dev-ruby/cms_scanner
	>=dev-ruby/addressable-2.5.0
	dev-ruby/activesupport:5.2
	>=dev-ruby/yajl-ruby-1.3.0
"

each_ruby_prepare() {
	sed -i -e '/s.add_development_dependency/d' wpscan.gemspec

	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}
